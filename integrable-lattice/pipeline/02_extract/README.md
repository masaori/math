# 02_extract

## 目的

論文からステートメント断片を抽出する。

## 抽出対象

- model names
- operation names
- theorem/proposition/conjecture/open problem/future work
- equation labels
- boundary conditions
- exact formula keywords

## 実装方針

- 初期版は keyword/rule-based。
- arXiv LaTeX source がある場合は source を優先する。
- PDF text は補助として使う。

