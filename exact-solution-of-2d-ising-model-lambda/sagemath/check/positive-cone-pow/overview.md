# SageMath Check: 正錐の元の冪は正錐の元である

**対象ラベル**: `claim_quadratic_positive_cone_pow_closed`

本文の自然数についての帰納法を厳密計算で確認する。$s^2=2$ の二つの根と、
正錐の三条件を覆う四つの表示について、出発点 $(1,0)$ と、積の表示による
各帰納法ステップが通常の代数的数の冪に一致し、正錐に留まることを確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/positive-cone-pow/check.sage
```

**2026-08-18 実行: すべて通過。**

## 等式から所属へ移す行の検算

有理数の一とその代数的数としての像を区別し、零乗・後者の冪の等式から台集合と正錐への所属をそれぞれ移す。
正錐の三条件を覆う八つの有理係数対（分数と純粋な生成元を含む）と二根の16例を調べる。
後者の場合は零乗から八乗までの144例、通常の冪との橋は零乗から九乗までの160例を調べる。

係数は二次数体で独立に計算した積・冪から取り出し、QQbar の積・冪と比較する。
入力の正錐条件だけを仮定し、積・冪が正錐に属するという結論で標本を絞らない。
負の平方根も用いるため、QQbar の実数順序を正錐の判定に代用していない。
有限標本の検算は一般の自然数についての帰納法を代替しない。

| ファイル | 本文の行・対応する橋 | 状態 | 結果 |
|---|---|---|---|
| `check_input_field.sage` | 始点の台集合への所属 | PASS | 16確認 |
| `check_rational_one_positive.sage` | 有理数の一の正値性 | PASS | 16確認 |
| `check_embedded_one_field.sage` | 有理数の一の像の台集合への所属 | PASS | 16確認 |
| `check_embedded_one_cone.sage` | 有理数の一の像の正錐への所属 | PASS | 16確認 |
| `check_zero_power.sage` | 零乗は代数的数の一 | PASS | 16確認 |
| `check_embedded_one_identity.sage` | 有理数の包含が一を保つ | PASS | 16確認 |
| `check_zero_field_transport.sage` | 零乗の等式から台集合への所属を移す | PASS | 16確認 |
| `check_zero_cone_transport.sage` | 零乗の等式から正錐への所属を移す | PASS | 16確認 |
| `check_product_field.sage` | 積の台集合への所属 | PASS | 144確認 |
| `check_product_cone.sage` | 積の正錐への所属 | PASS | 144確認 |
| `check_successor_power.sage` | 後者の冪の定義 | PASS | 144確認 |
| `check_successor_field_transport.sage` | 後者の等式から台集合への所属を移す | PASS | 144確認 |
| `check_successor_cone_transport.sage` | 後者の等式から正錐への所属を移す | PASS | 144確認 |
| `check_coe_bridge.sage` | 二次数体の冪の像と通常の代数的数の冪との橋 | PASS | 160確認 |

各行別ファイルは通常の SageMath CLI でも単独実行できる。
既存の両根・四表示・72帰納法ステップの統合検算を保持し、その後で上の十四行を実行する。
Lean は具体版・必要十分版とも二つの所属を同時に帰納し、再帰の等式による移し替えを明示する。
通常の冪との橋にも両版と導出版があり、導出版の所属の根拠は先行する正の有理数と乗法の導出版に接続する。

2026-10-12 実行: 本文十三行と通常の冪との橋の計1,008確認、および既存の72帰納法ステップが通過した。
統合ファイルと全十四行別ファイルの計15本を通常の SageMath CLI で単独実行し、すべて通過した。
対応する Lean 具体版・必要十分版・導出版の三モジュールの対象ビルドも通過した。
