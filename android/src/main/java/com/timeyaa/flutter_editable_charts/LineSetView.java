package com.timeyaa.flutter_editable_charts;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.LinearLayout;

import com.github.mikephil.charting.charts.LineChart;

public class LineSetView extends LinearLayout {

    private LineChart lineChart;

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
    }
}
