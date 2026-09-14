# SageMath 検算: 有限舞台上の二次の局所規則族

## 対象

**対象ラベル**: `theorem_second_order_global_evolution_bijective`

- 併せて検証するラベル: `claim_second_order_base_family_unique`、
  `claim_second_order_membership_finite_decidable`、`claim_binary_state_addition_cancellation`、
  `claim_second_order_inverse_after_evolution`、`claim_second_order_evolution_after_inverse`、
  `claim_general_binary_rule_not_forced_reversible`。
- 基礎局所規則族の回復と一意性、所属の有限判定、明示逆写像の左右の合成、
  一般の一段規則との境界を、本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_base_family_recovery.sage` | 基礎表から二次表を作り、前状態を零に固定した回復が元の表を返すことと、同じ二次表を表す別の基礎表が存在しないことを全候補と比較する | PASS | 二元以下の全近傍と全基礎真理値表で成立 |
| `check_membership_finite_decision.sage` | 二次の定義式を全入力で比較する有限走査と、基礎表から生成した二次表の全数列挙による所属判定を比較する | PASS | 二元以下の全近傍・全二時刻真理値表で一致 |
| `check_inverse_equalities.sage` | 二元体加法の二つの消去等式と、二時刻発展・逆写像候補の左右の合成が恒等写像になることを検査する | PASS | 二セル以下の全近傍割り当て・全基礎局所規則族・全二時刻配位で成立 |
| `check_general_one_step_counterexample.sage` | 一セル定値規則が二つの異なる配位を同じ配位へ写し、単射でも全単射でもないことを検査する | PASS | 一セル舞台の全二配位で反例成立 |

## 範囲と限界

- 基礎表の回復と所属判定は、二元以下の近傍の全真理値表を尽くす。逆写像の検算は、二セル以下の
  全近傍割り当て、各近傍上の全基礎局所規則族、全二時刻配位を尽くす。
- これらは明示した有限範囲のプログラミングによる検証であり、一般の有限舞台についての証明ではない。
  一般証明は構造化記述にある。
- 二時刻大域写像の可逆性は、基礎大域写像自体の可逆性を仮定しない。検算も全ての基礎局所規則族を
  列挙し、可逆なものだけへ制限していない。
- 有限集合と二元体加法の有限表だけを使う。対数、除算、浮動小数点、全配位の逆極限、極限、
  実数体・複素数体は使わない。

## 実行方法

```bash
for file in sagemath/check/second-order-rule-class/check_*.sage; do sage "$file"; done
```
