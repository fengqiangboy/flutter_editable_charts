package com.timeyaa.flutter_editable_charts;

import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.widget.LinearLayout;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.components.XAxis;
import com.github.mikephil.charting.components.YAxis;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.interfaces.datasets.ILineDataSet;

import java.util.ArrayList;

public class LineSetView extends LinearLayout {

    private LineChart lineChart;

    private LineDataSet dataSet = initDataSet();

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
}
