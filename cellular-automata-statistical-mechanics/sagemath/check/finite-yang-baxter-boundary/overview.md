# SageMath 検算: 有限 Yang–Baxter 条件と複素スペクトル依存性の境界

## 対象

**対象ラベル**: `claim_single_finite_yang_baxter_map_does_not_determine_spectral_dependence`

- 併せて検証するラベル: `claim_finite_yang_baxter_condition_decidable`、
  `claim_finite_swap_is_yang_baxter`、`claim_two_element_pair_map_not_always_yang_baxter`、
  `claim_finite_braid_solution_gives_constant_complex_yang_baxter_family`。
- 有限 braid 条件、成分交換による二規約の変換、複素線形化による定数族、
  一点で一致する相異なるスペクトルパラメータ族を段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_finite_braid_condition.sage` | 全三体入力による有限判定、成分交換例、二元反例 | PASS | 成分交換 441 入力、二元二体写像 256 個を検査し、解は 43 個 |
| `check_braid_yang_baxter_convention_equivalence.sage` | 隣接 braid 規約と成分交換後の非隣接 Yang–Baxter 規約の同値 | PASS | 全 256 写像・2,048 三体入力で同値、両規約の解は各 43 個 |
| `check_complex_linearization_constant_family.sage` | 複素線形化の単射性と定数族の Yang–Baxter 等式 | PASS | 全 256 写像の 1,024 基底列を復元し、43 解の 5,504 行列成分を比較 |
| `check_spectral_dependence_nonuniqueness.sage` | 同じ一点へ制限される定数族と非定数族の厳密な非一致 | PASS | 有理多項式恒等式が成立し、$(0,0)$ で一致、$(1,0)$ で $1\ne2$ |

## 範囲と限界

- 二元集合上の二体写像 256 個は全数検査する。一般の有限集合については本文の有限写像外延性による証明を代用しない。
- 複素線形化の等式は整数係数零一行列で、スペクトル族の反例は有理係数多項式環で厳密に判定する。
  係数埋め込みにより複素数上でも等式が保たれるため、浮動小数点は使わない。
- 連続性、極限、微分、内積、完備性、近似は検算対象にも導入しない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-yang-baxter-boundary/check_*.sage; do sage "$file"; done
```
