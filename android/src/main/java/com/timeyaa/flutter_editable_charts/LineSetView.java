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

public class LineSetView extends LinearLayout {

    private LineChart lineChart;

    private LineDataSet dataSet = initDataSet();

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
                            valueChangeListener.onChanging();
                        }
                        break;
                    case MotionEvent.ACTION_CANCEL:
                        if (valueChangeListener != null) {
                            valueChangeListener.onFinish();
                        }
                        break;
                }

                valueChange(nValue);

                return true;
            }
        });
    }

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

    public interface ValueChangeListener {
        void onStart();

        void onChanging();

        void onFinish();
    }
}


