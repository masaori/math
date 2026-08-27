# SageMath Check: 有理点 2 では有限箱の量は末尾周期的にならない

## 対象

**対象ラベル**: `claim_eventually_periodic_at_two_is_impossible`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_eventually_periodic_at_two_is_impossible`）
- 範囲: 有理点 2 での有限箱の値が法 4 で 2 であることから奇数因子を取り出す段、周期だけ離れた
  二箱の冪等式の両辺から素数 2 の共通冪を除く段、残った両辺の偶奇が食い違う段
- 併せて検証: `claim_eventual_power_form_at_two_is_impossible` の法 4 の簡約、
  `claim_eventually_periodic_iff_power_identity` の冪等式の形

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_values_at_two_have_odd_half.sage` | 有理点 2 の値が法 4 で 2 であり、2 で割った商が奇数（2 の指数がちょうど 1）であること | PASS | 一辺 2・3・4 の箱で成立 |
| `check_period_power_identity_parity_contradiction.sage` | 周期の冪等式から共通冪 $2^{L^3}$ を除く式変形が恒等式であり、残った左辺が偶数・右辺が奇数になること | PASS | 一辺 2〜4・周期 1〜3・奇数の組 16 通りで成立 |
| `check_real_boxes_fail_period_identity.sage` | 実データで両辺の 2 の指数が $(L+p)^3$ と $L^3$ になり等号が成り立たないこと | PASS | 一辺 2・3・4 の全ての組で成立 |

## 備考

- `ZZ` だけを使う。値は層転送で厳密に求め、全配位の列挙が回らない一辺 3・4 の箱も扱う。
- 二番目のファイルは実データに縛らない一般の奇数標本で偶奇の段を確かめる。本文の論法が
  値の具体形ではなく 2 の指数だけに依っていることの確認である。
- 浮動小数点、箱の大きさの極限、実対数、指数関数、無限和は使わない。
- 2026-08-28 に全ファイルを実行し、すべて通過した。

## 実行方法

```sh
for f in sagemath/check/eventually-periodic-at-two-impossible/check_*.sage; do sage "$f"; done
```
