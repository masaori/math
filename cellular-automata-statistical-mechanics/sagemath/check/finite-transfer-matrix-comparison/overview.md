# SageMath 検算: 有限遷移重みの転送行列・跡・決定論的状態数との比較

## 対象

**対象ラベル**: `theorem_deterministic_transfer_trace_equals_fixed_point_count`

- 併せて検証するラベル: `def_rational_transition_transfer_matrix`、
  `def_rational_transfer_matrix_power_trace`、`claim_transfer_matrix_power_equals_finite_step_weight`、
  `def_deterministic_rule_zero_one_embedding`、`claim_deterministic_transfer_matrix_entry`、
  `claim_deterministic_transfer_matrix_power_entry`。
- 有理大域遷移重みから行を現在配位・列を次配位とする有限行列への比較、有限和積による行列冪、
  決定論的規則族の零一埋め込み、跡と反復不動点数の一致を本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_transfer_matrix_comparison.sage` | 大域遷移重みを値を変えずに有限有理行列へ送り、行列の向きを非対称な定値規則の証人で固定する | PASS | 13 規則族・85 成分と向きの証人で成立 |
| `check_power_equals_finite_transition.sage` | 零回の等号指示値と帰納段の有限和積を照合し、行列冪と有限回遷移重みの全成分を比較する | PASS | 13 規則族・65 冪・425 成分・340 帰納成分で成立 |
| `check_deterministic_entries_and_powers.sage` | 零一埋め込みの一段成分と零回から四回までの冪を、決定論的大域写像の反復遷移指示値と比較する | PASS | 全 261 規則族・4,113 一段成分・20,565 冪成分で成立 |
| `check_trace_equals_fixed_point_count.sage` | 跡、対角指示値和、反復不動点集合の元数を段別に比較し、正の場合だけ素因数指数ベクトルを作る | PASS | 全 261 規則族の 2,088 跡で成立。正 1,700 入力を分解し、零 388 入力を除外 |

## 範囲と限界

- 有理遷移重みと行列冪は、空舞台・一セル舞台の候補重み `0, 1/2, 1` による全規則族と、
  二セル舞台の三つの明示規則族を検査する。冪は零回から四回までであり、極限や収束を主張しない。
- 決定論的な成分と冪は、セル数二以下で各セルが現在配位全体を見る全 261 規則族を検査する。
  跡は同じ全規則族について一回から八回まで検査する。
- 上記は明示した有限範囲のプログラミングによる検証であり、任意の有限舞台についての証明ではない。
  一般証明は構造化記述にある。
- 全て有限集合、`QQ`、`ZZ`、有限和積、正値時の素因数分解として厳密に検査する。
  零では対数入力を作らない。浮動小数点、未定義の除算、全配位の逆極限、極限、実数体・複素数体は使わない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-transfer-matrix-comparison/check_*.sage; do sage "$file"; done
```
