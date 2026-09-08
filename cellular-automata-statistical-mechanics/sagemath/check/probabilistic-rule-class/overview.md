# SageMath 検算: 有限舞台上の有理重みの確率的局所規則族

## 対象

**対象ラベル**: `theorem_probabilistic_global_transition_normalized`

- 併せて検証するラベル: `def_rational_probabilistic_local_rule_family`、
  `def_probabilistic_local_output_weight`、`def_probabilistic_global_transition_weight`、
  `claim_probabilistic_finite_step_rational_closure`、`claim_probabilistic_membership_finite_decidable`、
  `claim_deterministic_rules_are_zero_one_probabilistic_rules`。
- 局所相補重み、大域遷移の正規化、有限回遷移の有理数閉性と正規化、有限表の所属判定、
  決定論的規則との零一重み境界を、本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_global_transition_normalization.sage` | 大域遷移重みの総和を有限和積の分配、局所正規化、単位元の三段へ分けて検査する | PASS | 6,571 規則族の 26,263 遷移行、105,013 重みで成立 |
| `check_finite_step_rational_closure.sage` | 零回の恒等遷移と有限回の合成について、有理数閉性・非負性・正規化を各段で検査する | PASS | 13 規則族、零回から四回までの 65 遷移、425 成分で成立 |
| `check_membership_finite_decision.sage` | 候補有理表の全入力を有限比較する所属判定を検査する | PASS | 650 表、2,550 比較で 90 表を受理し 560 表を拒否 |
| `check_deterministic_zero_one_boundary.sage` | 零一重みからの決定論的規則の一意回復と、二分の一重みの非決定論的境界を検査する | PASS | 6,570 族中 260 零一族を回復し 4,112 遷移指示値と二分の一反例を確認 |

## 範囲と限界

- 大域正規化はセル数二以下、候補重みを `0, 1/2, 1` とした全 6,571 局所規則族を尽くし、
  全入力配位の遷移行を検査する。
- 有限回遷移はセル数一以下の同じ候補重みによる全規則族と、二セルの三つの明示規則族について、
  零回から四回までを検査する。有限回だけを扱い、極限や収束を主張しない。
- 所属判定はセル数一と二について、候補値 `-1/2, 0, 1/2, 1, 3/2` からなる全局所有理表を
  入力全件の有理順序比較で判定する。
- 決定論的境界はセル数一と二、候補重み `0, 1/2, 1` の全規則族を走査し、零一族だけについて
  回復した決定論的大域更新と遷移指示関数の一致を検査する。一セルの一定二分の一重みを反例にする。
- 以上は明示した有限範囲のプログラミングによる検証であり、一般の有限舞台についての証明ではない。
  一般証明は構造化記述にある。有理数体上で定義済みの除算だけを使い、未定義の対数・除算、
  浮動小数点、全配位の逆極限、極限、実数体・複素数体は使わない。

## 実行方法

```bash
for file in sagemath/check/probabilistic-rule-class/check_*.sage; do sage "$file"; done
```
