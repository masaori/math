# SageMath Check: 末尾周期性と周期だけ離れた箱の冪等式の同値

## 対象

**対象ラベル**: `claim_eventually_periodic_iff_power_identity`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_eventually_periodic_iff_power_identity`）
- 範囲: 末尾周期性から交差べき等式を得る向きと、交差べき等式から周期だけ離れた二項の等号および末尾周期性を得る逆向き
- 併せて検証: `def_limit_quantity_from_finite_box_sequence`、`def_eventually_periodic_finite_box_sequence`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_eventual_periodic_implies_power_identity.sage` | 共通値から両側の交差べきが同じ冪になる式変形 | PASS | 4 個の正の有理数と 3 組の箱点数で成立 |
| `check_power_identity_implies_periodic_equality.sage` | 交差べき等式と共通正整数冪の等式の同値、および正の値に対する冪の単射性 | PASS | 4 個の正の有理数の全 16 組と 3 組の箱点数で成立 |
| `check_period_one_matches_eventually_constant.sage` | 周期 1 の冪等式が隣接箱の冪等式に一致すること、および閾値以後の周期等号が剰余類ごとの定数性を与えること | PASS | 一辺 1〜4 の箱で指数が一致、閾値 3・周期 4 で添字 19 まで成立 |

## 備考

- `QQ` と `ZZ` だけを使い、本文で実数乗根を消去した後の可算側の式変形を厳密に検査する。
- 正の実数全体での正整数冪の単射性そのものは SageMath の有限計算へ置き換えず、Lean 具体版で全称的に形式化する対象として残す。
- 剰余類ごとの定数性は本文の主張ではなく、周期等号が末尾周期性の定義どおりに働くことの確認である。
- 浮動小数点と箱の大きさの極限は使わない。
- 2026-08-27 に全ファイルを実行し、すべて通過した。

## 実行方法

```sh
for f in sagemath/check/eventually-periodic-iff-power-identity/check_*.sage; do sage "$f"; done
```
