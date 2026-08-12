# SageMath Check: 実現できる破れた辺集合の双対像は自明セクターの全体である

## 対象

**対象ラベル**: `claim_attainable_dual_image_trivial_sector`

- 併せて検証: `def_attainable_broken_edge_sets`、`def_dual_edge_map`、`def_torus_homology_sector`
- 範囲: 実現できる破れた辺集合の全体 $\mathfrak{B}_L$ の双対像と、自明セクター $\mathcal{E}^{0,0}_L$ の全体が集合として一致すること

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ について、全配位から $\mathfrak{B}_L$ を数え上げ、その双対像の集合と、全辺部分集合から数え上げた自明セクターの全体が一致することを厳密検査する | PASS | 全件一致 |

## 実行方法

```sh
sage sagemath/check/attainable-dual-image-trivial-sector/check.sage
```

**2026-08-13 実行: すべて通過。**
