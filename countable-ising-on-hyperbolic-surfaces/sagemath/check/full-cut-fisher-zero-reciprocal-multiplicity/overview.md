# 全辺二分割をもつ有限グラフの Fisher 零点重複度の逆数対称性の検算

**対象ラベル**: `theorem_full_cut_fisher_zero_reciprocal_multiplicity`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_full_cut_fisher_zero_reciprocal_multiplicity`）
- 範囲: 最高次・定数項の非零性、相反恒等式への一次因子分解の代入、逆順余因子の多項式性と逆数点での非零性、零点重複度の一致
- 併せて検証: `theorem_partition_polynomial_reciprocity_characterizes_full_cut`、`theorem_full_cut_coefficient_symmetry`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_degree_and_nonzero_constant.sage` | 全辺二分割から次数が辺数に等しく定数項が非零であることを照合 | PASS | 全五例で次数、定数項、最高次係数を照合 |
| `check_reciprocal_factor_substitution.sage` | 相反恒等式と一次因子分解の逆数代入を照合 | PASS | 全五例の全零点と非零点で一致 |
| `check_extract_inverse_monomial.sage` | 逆数一次因子から Laurent 単項式を抽出する等式を照合 | PASS | 全五例の全検査点で一致 |
| `check_rewrite_inverse_linear_factor.sage` | 一次因子を逆数点の一次因子へ書き換える等式を照合 | PASS | 全五例の全検査点で一致 |
| `check_reversed_cofactor.sage` | 逆順余因子が代数的数係数多項式に属することを照合 | PASS | 全五例の全検査点で `QQbar[x]` への所属を確認 |
| `check_reversed_cofactor_nonzero.sage` | 逆順余因子の逆数点評価と非零性を照合 | PASS | 全五例の全検査点で評価式と非零性を確認 |
| `check_inverse_multiplicity.sage` | 非零代数的数とその逆数における重複度を照合 | PASS | 全五例の全検査点で重複度が一致 |

## 備考

- 一頂点無辺、一辺、三頂点道、四頂点サイクル、二本の平行辺を用いる。
- 各多項式の全零点に加え、重複度零の場合を正確に検査するため非零な非零点も用いる。
- 有限集合、`NN`、`ZZ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/check_*.sage; do
  sage "$file"
done
```
