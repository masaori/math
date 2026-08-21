# 全辺二分割をもつ有限グラフの零点 -1 の重複度の偶奇の検算

**対象ラベル**: `theorem_full_cut_fisher_zero_minus_one_multiplicity_parity`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_full_cut_fisher_zero_minus_one_multiplicity_parity`）
- 範囲: 零点重複度の総和、逆数写像の非固定二元軌道、零点 `1` の重複度零、零点 `-1` の重複度と辺数の偶奇
- 併せて検証: `theorem_full_cut_fisher_zero_reciprocal_multiplicity`、`claim_partition_polynomial_value_at_one`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_root_multiplicity_sum.sage` | `QQbar` 上の全零点重複度の総和が辺数に等しいことを照合する | PASS | 全五例で重複度総和と辺数が一致 |
| `check_inverse_orbit_evenness.sage` | `-1,1` 以外の零点が重複度を保つ逆数二元軌道へ分かれ、その重複度総和が偶数であることを照合する | PASS | 全五例で逆数点の帰属・重複度一致・偶数性を確認 |
| `check_positive_one_multiplicity.sage` | `1` における評価が全配位数で非零となり、零点重複度が零であることを照合する | PASS | 全五例で評価値と重複度零を確認 |
| `check_minus_one_parity.sage` | 零点 `-1` の重複度と辺数の偶奇が一致することを照合する | PASS | 無辺グラフを含む全五例で一致 |

## 備考

- 一頂点無辺、一辺、三頂点道、四頂点サイクル、二本の平行辺を用いる。無辺グラフでは零点台を空集合として扱う。
- 有限集合、`NN`、`ZZ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。
- リポジトリ直下以外から実行した二度の試行では、リポジトリ相対の検算ファイルまたは `_prelude.sage` を解決できず `ERROR` となった。いずれも実行場所をリポジトリ直下へ戻して同じ四件を再実行し、全件 `PASS` した。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-minus-one-multiplicity-parity/check_*.sage; do
  sage "$file"
done
```
