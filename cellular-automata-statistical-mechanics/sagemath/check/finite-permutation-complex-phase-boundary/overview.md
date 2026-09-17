# SageMath 検算: 有限置換時間発展と複素位相実現の境界

## 対象

**対象ラベル**: `claim_binary_ca_real_phase_generator_not_unique`

- 併せて検証するラベル: `claim_binary_ca_permutation_matrix_powers_encode_iterates`、
  `claim_binary_ca_reversible_global_finite_order_identity`、
  `claim_binary_ca_phase_code_realizes_complex_eigenpair`、
  `claim_binary_ca_permutation_complex_eigenvalue_root_of_unity`。
- 整数置換行列の冪、周期軌道長の最小公倍数による有限位数、有限位相符号の固有対、
  全固有値の一の冪根性、整数持ち上げによる生成子の非一意性を段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_permutation_matrix_powers.sage` | 整数置換行列の冪と有限写像表の反復の成分ごとの一致 | PASS | 全 5,913 置換、86,551 冪、4,078,237 成分で一致 |
| `check_finite_order_identity.sage` | 周期軌道長の最小公倍数による写像表と置換行列の恒等化 | PASS | 全 46,233 置換、124,755 周期軌道で成立 |
| `check_phase_eigenpairs.sage` | 有限位相符号から作る円分体上の位相ベクトルと固有値等式 | PASS | 全 5,913 置換、40,319 位相符号、276,327 成分で成立 |
| `check_all_eigenvalues_roots.sage` | 特性多項式の周期軌道因子分解と全固有値の有限位数制約 | PASS | 全 46,233 置換、124,755 周期多項式因子で成立 |
| `check_generator_lift_nonuniqueness.sage` | 相異なる整数持ち上げの有理係数表示と整数剰余での一致 | PASS | 全 46,233 置換、362,879 位相符号、26,127,288 持ち上げ対で成立 |

## 範囲と限界

- 配位集合の元数一から七では全置換 5,913 個について行列冪と全位相符号の固有対を検査する。
  有限位数、特性多項式、生成子の持ち上げは元数一から八の全置換 46,233 個を検査する。
- 位相固有対は浮動小数点の複素数ではなく円分体の代数的数で判定する。全固有値の主張は、
  特性多項式が軌道長 `d` ごとの `t^d-1` の積であることと、各 `d` が有限位数を割ることを判定する。
- 生成子については、本文の共通実数係数 `2*pi/tau` を数値近似せず、その前の有理係数
  `k/d+n` が相異なり、差が整数であることを厳密に判定する。複素指数の周期性と正の共通係数による
  非一致は本文の一般証明が担い、この有限検算で一般証明を代用しない。
- 複素対数、内積、完備性、無限体積、極限は導入しない。複素数側は有限円分体だけを使う。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-permutation-complex-phase-boundary/check_*.sage; do sage "$file"; done
```
