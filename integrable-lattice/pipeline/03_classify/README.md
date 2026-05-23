# 03_classify

## 目的

抽出された断片を taxonomy に写す。

## 分類軸

- model_family
- model
- operation_type
- statement_type
- boundary_condition
- parameter regime
- solved/open/unknown

## 実装方針

- seed taxonomy による rule-based 分類から始める。
- ambiguity が高いものは `inputs/labels/` に回して人手確認する。

