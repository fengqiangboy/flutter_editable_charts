package com.timeyaa.flutter_editable_charts;

import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.widget.LinearLayout;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.components.XAxis;
import com.github.mikephil.charting.components.YAxis;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.interfaces.datasets.ILineDataSet;
import com.github.mikephil.charting.listener.ChartTouchListener;
import com.github.mikephil.charting.utils.MPPointD;

import java.util.ArrayList;
import java.util.List;

public class LineSetView extends LinearLayout {

    /**
     * 曲线对象
     */
    private LineChart lineChart;

    /**
     * 曲线数据集
     */
    private LineDataSet dataSet = initDataSet();

    /**
     * 数据改变回调
     */
    private ValueChangeListener valueChangeListener;

    public LineSetView(Context context) {
        this(context, null);
    }

    public LineSetView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public LineSetView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);

        inflate(context, R.layout.layout_editable_charts, this);
        lineChart = findViewById(R.id.line_chart);

        initLineChart();
    }

    public void setValueChangeListener(ValueChangeListener valueChangeListener) {
        this.valueChangeListener = valueChangeListener;
    }

    public void setLineData(List<LineDataModel> dataModels) {
        dataSet.getValues().clear();

        if (dataModels == null || dataModels.size() == 0) {
            return;
        }

        for (int i = 0; i < dataModels.size(); i++) {
            LineDataModel dataModel = dataModels.get(i);
            Entry nEntry = new Entry(dataModel.getX(), dataModel.getY());
            dataSet.getValues().add(nEntry);
        }

        XAxis xAxis = lineChart.getXAxis();
        xAxis.setAxisMinimum(0f);
        xAxis.setAxisMaximum(dataModels.get(dataModels.size() - 1).getY());
        xAxis.setLabelCount(dataModels.size(), true);

        YAxis axisLeft = lineChart.getAxisLeft();
        axisLeft.setAxisMinimum(0f);
        axisLeft.setAxisMaximum(50);

        dataSet.setDrawValues(true);
        dataSet.setValueTextColor(Color.WHITE);

        dataSet.notifyDataSetChanged();
        lineChart.invalidate();
    }

    public void setLineBoundaryData(double minX, double maxX, int xLabelCount, double xSpaceMin, double minY, double maxY) {
        XAxis xAxis = lineChart.getXAxis();
        xAxis.setAxisMinimum((float) minX);
        xAxis.setAxisMaximum((float) maxX);
        xAxis.setSpaceMin((float) xSpaceMin);
        xAxis.setLabelCount(xLabelCount, true);

        YAxis axisLeft = lineChart.getAxisLeft();
        axisLeft.setAxisMinimum((float) minY);
        axisLeft.setAxisMaximum((float) maxY);

        dataSet.notifyDataSetChanged();
        lineChart.invalidate();
    }

    /**
     * 将曲线数据全部读出
     *
     * @return 曲线上面的数据点
     */
    public List<LineDataModel> getLineData() {
        List<Entry> values = dataSet.getValues();
        List<LineDataModel> results = new ArrayList<>(values.size());
        for (int i = 0; i < values.size(); i++) {
            Entry entry = values.get(i);
            results.add(new LineDataModel(entry.getX(), entry.getY()));
        }

        return results;
    }

    /**
     * 初始化曲线样式
     */
    private void initLineChart() {
        lineChart.setGridBackgroundColor(Color.WHITE);
        lineChart.getDescription().setEnabled(false);

        XAxis xAxis = lineChart.getXAxis();
        xAxis.setPosition(XAxis.XAxisPosition.BOTTOM);
        xAxis.setAvoidFirstLastClipping(true);
        xAxis.setAxisMinimum(0f);
        xAxis.setAxisMaximum(10f);
        lineChart.setMaxVisibleValueCount(10);
        xAxis.setTextColor(Color.WHITE);

        YAxis axisLeft = lineChart.getAxisLeft();
        axisLeft.setTextColor(Color.WHITE);
        axisLeft.setAxisMaximum(50);
        axisLeft.setAxisMinimum(0);

        lineChart.getAxisRight().setEnabled(false);
        lineChart.getLegend().setEnabled(false);
        lineChart.setPinchZoom(false);
        lineChart.setDoubleTapToZoomEnabled(false);

        ArrayList<ILineDataSet> list = new ArrayList<>();
        list.add(dataSet);

        LineData lineData = new LineData(list);
        lineData.setValueTextColor(Color.WHITE);
        lineData.setValueTextSize(9);

        lineChart.setData(lineData);

        // 手势处理
        lineChart.setOnTouchListener(new ChartTouchListener<LineChart>(lineChart) {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if (event == null || v == null) {
                    return false;
                }

                LineChart view = (LineChart) v;
                MPPointD nValue = view.getValuesByTouchPoint(event.getX(), event.getY(), YAxis.AxisDependency.LEFT);

                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:
                        if (valueChangeListener != null) {
                            valueChangeListener.onStart();
                        }
                        view.performClick();
                        break;
                    case MotionEvent.ACTION_UP:
                        if (valueChangeListener != null) {
                            valueChangeListener.onFinish();
                        }
                        break;
                    case MotionEvent.ACTION_CANCEL:
                        if (valueChangeListener != null) {
                            valueChangeListener.onFinish();
                        }
                        break;
                    case MotionEvent.ACTION_MOVE:
                        if (valueChangeListener != null) {
                            valueChangeListener.onChanging();
                        }
                        break;
                }

                valueChange(nValue);

                return true;
            }
        });
    }

    /**
     * 初始化数据集
     *
     * @return 一个空数据的数据集
     */
    private LineDataSet initDataSet() {
        ArrayList<Entry> entries = new ArrayList<>(5);
        for (int i = 0; i < 5; i++) {
            entries.add(new Entry(i, i * 10));
        }

        LineDataSet dataSet = new LineDataSet(entries, null);
        dataSet.setHighlightEnabled(false);
        dataSet.setCubicIntensity(0.2f);
        dataSet.setDrawCircles(false);
        dataSet.setDrawIcons(false);
        dataSet.setCircleColor(Color.GREEN);
        dataSet.setCircleColor(Color.GREEN);
        dataSet.setValueTextSize(30f);
        dataSet.setValueTextSize(30f);
        dataSet.setDrawFilled(true);
        dataSet.setDrawValues(true);
        dataSet.setLineWidth(1.5f);
        dataSet.setMode(LineDataSet.Mode.CUBIC_BEZIER);
        dataSet.setColor(Color.GREEN);

        dataSet.setCircleRadius(5);

        return dataSet;
    }

    /**
     * 数据改变回调
     *
     * @param nValue 新数据
     */
    private void valueChange(MPPointD nValue) {
        // 获取数据源
        ILineDataSet data = lineChart.getData().getDataSetByIndex(0);

        // 遍历数据，获取最接近的那个
        for (int i = 0; i < data.getEntryCount(); i++) {
            Entry entry = data.getEntryForIndex(i);

            if (Math.abs(entry.getX() - nValue.x) < 0.2) {
                entry.setY((float) nValue.y);
            }
        }

        dataSet.notifyDataSetChanged();
        lineChart.notifyDataSetChanged();
        lineChart.invalidate();
    }

    /**
     * 数据改变观察接口
     */
    public interface ValueChangeListener {
        void onStart();

        void onChanging();

        void onFinish();
    }
}


