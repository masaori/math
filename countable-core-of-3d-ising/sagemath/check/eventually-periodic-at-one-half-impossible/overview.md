# SageMath Check: 有理点 2 分の 1 では有限箱の量は末尾周期的にならない

## 対象

**対象ラベル**: `claim_eventually_periodic_at_one_half_is_impossible`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_eventually_periodic_at_one_half_is_impossible`）
- 範囲: 回文性（有限和の添字変更）で有理点 2 分の 1 の値を有理点 2 の値へ移す段、そこから
  素因子 2 の指数が $1-\#E_M$ になる段、周期の冪等式が強制する指数等式の両辺の差を
  分配法則で書き換えて正であることを見る段
- 併せて検証: `claim_eventual_power_form_at_two_is_impossible` の素因子 2 の指数が 1 であること

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_palindromic_transfer_to_two.sage` | 分配多項式の次数が辺数に等しく、$2^{\#E_M}Z_M(1/2)=Z_M(2)$ が成り立つこと | PASS | 一辺 2・3 の箱で成立 |
| `check_one_half_valuation_is_one_minus_edge_count.sage` | $Z_M(2)$ の素因子 2 の指数が 1 であり、$Z_M(1/2)$ の素因子 2 の指数が $1-\#E_M$ であること | PASS | 一辺 2・3 の箱で成立 |
| `check_period_index_difference_is_positive.sage` | 指数等式の左辺から右辺を引くと $(L+p)^3-L^3+3pL^2(L+p)^2$ に等しい（分配法則の段が恒等式）ことと、その全係数が正であること | PASS | $\mathbb Z[L,p]$ の恒等式として成立。一辺 2・3、周期 1〜3 の実データでも差が正 |

## 備考

- 有理点 2 分の 1 の値は、回文性の関係を仮定せずに分配多項式そのものへ代入して独立に得る
  （層転送の高速版は整数点しか受け取らないため、多項式を層転送で作ってから代入する）。
  そのぶん一辺 4 の箱は回らないので一辺 2・3 にとどめた。
- 三番目のファイルは実データに縛らない $\mathbb Z[L,p]$ の恒等式として差を確かめる。本文の論法が
  箱の値そのものではなく辺数と点数の形だけに依っていることの確認である。
- `ZZ` と `QQ` だけを使う。浮動小数点、箱の大きさの極限、実対数、指数関数、無限和は使わない。
- 2026-08-28 に全ファイルを実行し、すべて通過した。

## 実行方法

```sh
for f in sagemath/check/eventually-periodic-at-one-half-impossible/check_*.sage; do sage "$f"; done
```
