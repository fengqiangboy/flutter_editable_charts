package com.timeyaa.flutter_editable_charts;

/**
 * 数据模型
 */
public class LineDataModel {

    /**
     * x 坐标
     */
    private float x;

    /**
     * y 坐标
     */
    private float y;

    public LineDataModel() {
    }

    public LineDataModel(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public float getX() {
        return x;
    }

    public void setX(float x) {
        this.x = x;
    }

    public float getY() {
        return y;
    }

    public void setY(float y) {
        this.y = y;
    }
}
