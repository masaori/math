# SageMath Check: 末尾定数性と隣接箱の冪等式の同値

## 対象

**対象ラベル**: `claim_eventually_constant_iff_power_identity`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_eventually_constant_iff_power_identity`）
- 範囲: 末尾定数性から交差べき等式を得る向きと、交差べき等式から隣接項の等号および末尾定数性を得る逆向き
- 併せて検証: `def_limit_quantity_from_finite_box_sequence`、`def_eventually_constant_finite_box_sequence`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_eventual_constant_implies_power_identity.sage` | 共通値から両側の交差べきが同じ冪になる式変形 | PASS | 4 個の正の有理数と 3 組の箱点数で成立 |
| `check_power_identity_implies_adjacent_equality.sage` | 交差べき等式と共通正整数冪の等式の同値、および正の値に対する冪の単射性 | PASS | 4 個の正の有理数の全 16 組と 3 組の箱点数で成立 |
| `check_adjacent_equality_implies_eventual_constant.sage` | 閾値以後の隣接等号を帰納的に末尾定数性へ束ねる段 | PASS | 閾値 3 から添字 12 まで成立 |

## 備考

- `QQ` と `ZZ` だけを使い、本文で実数乗根を消去した後の可算側の式変形を厳密に検査する。
- 正の実数全体での正整数冪の単射性そのものは SageMath の有限計算へ置き換えず、Lean 具体版で全称的に形式化する対象として残す。
- 浮動小数点と箱の大きさの極限は使わない。
- 2026-08-24 に全ファイルを実行し、すべて通過した。

## 実行方法

```sh
for f in sagemath/check/eventually-constant-iff-power-identity/check_*.sage; do sage "$f"; done
```
