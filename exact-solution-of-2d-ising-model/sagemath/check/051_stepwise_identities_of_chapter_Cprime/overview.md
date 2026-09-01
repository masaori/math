# SageMath Check: 051_stepwise_identities_of_chapter_Cprime

## 対象

**対象ラベル**: `commutator_of_H_and_check_Z_Y` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/013_even_sector_modes.ts`,
  `014_even_sector_T_action.ts`, `015_A_theta_tilde_diagonalization.ts`,
  `016_even_sector_fermions.ts`
- 併せて検証（章 C′ の全ブロック）:
  - 013 章: `why_008_applies_only_to_minus_sector` / `antiperiodic_exp_sum` /
    `def_half_integer_modes` / `commutator_of_H_and_check_Z_Y` /
    `anticommutator_of_check_Z_Y` / `recover_Z_Y_from_check_Z_Y` / `H1_H2_via_check_Z_Y`
  - 014 章: `def_H1_plus` / `def_V1_plus_square_root` / `V1_plus_square_root_property` /
    `def_V_plus` / `V_plus_factors_invertible` / `def_T_V_plus` / `T_V_plus_is_conjugation` /
    `nesting_of_commutator_of_H_and_check_Z` /
    `cosh_sinh_coefficient_conversion_for_check` / `extract_taylor_coefficient_of_check_Z_Y` /
    `T_actions_on_check_Z_Y` / `linearity_of_T_on_check_Z_Y` / `calc_of_TxT_check_Z_Y` /
    `factorization_of_A_theta_general` / `T_V_plus_check_Z_Y`
  - 015 章: `def_gamma1_gamma2_of_theta` / `gamma_2_theta_tilde_nonzero` /
    `relation_of_gamma_2_theta_tilde` / `eigenvector_of_A_theta_tilde` /
    `diagonalization_check_P_D` / `det_A_theta_tilde` / `gamma1_gt_1_theta_tilde` /
    `def_gamma_theta_tilde_mu` / `lambda_eq_exp_gamma_theta_tilde`
  - 016 章: `def_check_fermi` / `periodicity_of_check_fermi` / `anticommutator_of_check_psi` /
    `commutation_V_plus_check_psi` / `def_check_Vprime` /
    `action_of_T_check_Vprime_on_check_psi` /
    `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` / `T_V_plus_eq_T_check_Vprime` /
    `V_plus_eq_c_check_Vprime`

### 何を確定させるための検証か

`046`〜`049` は章 C′ の各ブロックの **statement（結論）** を数値で確かめている。
この `050` はそれとは目的が違う。

章 C′ の証明を「1 ステップ 1 定理」の規約（`.claude/skills/math-prover/SKILL.md`）へ
適合させる作業で、**1 行に潰れていた式変形を段に分割し、各段に
`\quad(\because ...)` で適用した定理を明記した**。分割の結果、本文には
**それまで書かれていなかった中間式が明示的に現れる**ようになっている。

**この検証の主眼は、その中間式の 1 段 1 段が実際に成り立っているかを確かめることにある。**
「結論だけ合っていて途中の段が間違っている」という状態を検出したい。したがって
各 `displayMath` の `&=` で区切られた行を、本文の並び順のとおりに 1 行ずつ
左辺・右辺として数値比較する。

とくに次の 2 箇所は、分割前に複数の操作が 1 行へ潰れていた箇所であり、重点的に段を刻んである。

1. `relation_of_gamma_2_theta_tilde` の共役計算（分割前は 1 行に 5 つ以上の操作）。
   `conj(zw) = conj z conj w` / `conj(i) = -i` /
   **`conj(e^{iθ}) = e^{-iθ}`（θ が実数であることを使う）** / `s_2*` が実数 /
   括弧内の共役 / `γ_2` の定義の再適用、を 8 段に分けて 1 段ずつ確かめる
   （`check_02` の `relation_of_gamma_2 (1)`〜`(8)`）。
2. `H1_H2_via_check_Z_Y` の展開（分割前は代入と `θ~_{1-μ} = -θ~_μ` の適用が同一行、
   さらに「積を二重和へ分配」と「有限和の順序交換」が同一行）。
   `checkZ_{1-μ}` の表示を 3 段、二重和の展開を 4 段に分けて確かめる
   （`check_01` の `H1_H2_via_check (Z1-mu ...)` と `(H2 ...)` `(H1 ...)`）。

## 検証の枠組み

`_prelude.sage` に `_shared/spin_ops.sage`（`Z_j, Y_j, H_1^{(±)}, H_2` の明示行列）の上へ
章 C′ の道具を積む。`049` の prelude と同じ定義に、013・014 章の証明で使う
**反周期的な延長** `Y^flat_l`, `Z^flat_l` と `B_1(θ), B_2` を足したもの。

```
theta~_mu   = 2 pi (mu - 1/2) / M
checkZ_mu   = sum_{j=1}^{M} Z_j e^{-i j theta~_mu}
checkY_mu   = sum_{j=1}^{M} Y_j e^{-i j theta~_mu}

Y^flat_0     = -Y_M,  Y^flat_j = Y_j (1<=j<=M)
Z^flat_{M+1} = -Z_1,  Z^flat_j = Z_j (1<=j<=M)

B_1(t) = [[cosh K_1, -i e^{it} sinh K_1], [i e^{-it} sinh K_1, cosh K_1]]
B_2    = [[cosh 2K_2*, i sinh 2K_2*], [-i sinh 2K_2*, cosh 2K_2*]]
A(t)   = [[gamma_1(t), gamma_2(t)], [-gamma_2(-t), gamma_1(t)]]
```

段ごとの残差は `Steps` クラスで集計する。`Steps.add(name, lhs, rhs)` の `name` には
本文の `\because` に書いた根拠（ラベル名など）をそのまま入れてあるので、
出力を読めば「どの段がどの定理に対応し、残差がいくつか」が 1 対 1 で追える。

### パラメータ

- `M = 2, 3, 4, 5`（`check_02` はさらに `M = 6, 7, 8`）
- `mu` は `1..M` に加えて `mu = 0, -1, M+1` も回す（本文の主張が `mu ∈ Z` 全体であるため）
- `(K_1, K_2)` は 6 組。**厳密な臨界点 2 点**（非等方・等方）、臨界点近傍、一般点 2 点、
  高温極限付近を含む
- `n` 重交換子は `n = 0..8`、テイラー級数は 40 次で打ち切り
- 判定閾値は `TOL = 1e-8`（`check_04` のみ `1e-7`。`V_2` の前因子 `(2 s_2)^{M/2}` と
  `exp(K_1 ...)` により行列のスケールが開くため）

## μ の量化範囲の絞り込み（2026-07-27）

章 C′ の主張の量化範囲を `μ ∈ ℤ` から `𝓜̌ = {1,…,M}`（`def_check_index_set`）へ絞り、
共役添字を `1−μ` から `M+1−μ` へ書き換えたのに合わせて、各段の検証を更新し
**再実行した**（`run-log.txt` はその出力）。

- check_01（013 章）: `def_check_index_set` (1)〜(5) と `conjugate_index_of_check_Z_Y`
  (1)(2)(3) の各段を追加。`H1_H2_via_check_Z_Y` の `Ž_{1−μ}` の 3 段は、
  `Ž_{M+1−μ}` の **2 段**（`def_half_integer_modes` → `conjugate_index_of_check_Z_Y` (2)）に
  置き換わった（合同式・符号反転の段が消えた）。段数 92 → 105。
- check_04（016 章）: `periodicity_of_check_fermi` の (1)(2)(3) の組み替えに追随。
  `anticommutator_of_check_psi` の Step 1 と `action_of_T_check_Vprime_on_check_psi` の
  Step 1 / Step 1' で、合同式のデルタと `M+1−μ` 形のデルタが一致することを 1 段として検証。
  段数 58 → 62。
- `μ` を走らせる範囲も、主張が `𝓜̌` 上のものになった箇所は `𝓜̌` に合わせた
  （`def_half_integer_modes` (1)(2)(3) の検証だけは `μ = 0, −1, M+1` を含めたまま残してある。
  これは `μ ∈ ℤ` で量化してよい 2 主張のうちの 1 つだからである）。

## 実行

```
cd exact-solution-of-2d-ising-model/sagemath/check/051_stepwise_identities_of_chapter_Cprime
sage check_01_013_steps.sage
sage check_02_015_steps.sage
sage check_03_014_steps.sage
sage check_04_016_steps.sage
```

## 結果

実際の実行出力は `run-log.txt` に置いてある。要約:

| ファイル | 対象 | 区別された段の種類 | 最大残差 | 判定 |
| --- | --- | --- | --- | --- |
| `check_01_013_steps.sage` | 013 章の各段 | 105 | 2.3e-14 | PASS |
| `check_02_015_steps.sage` | 015 章の各段 | 66 | 1.7e-13 | PASS |
| `check_03_014_steps.sage` | 014 章の各段 | 100 | 9.5e-11 | PASS |
| `check_04_016_steps.sage` | 016 章の各段 | 62 | 5.8e-12 | PASS |

**章 C′ の 4 章あわせて 333 種類の段がすべて成り立っている。**

副産物として、次の 3 つの狭義不等号も再確認した（本文が半整数運動量に固有の帰結として
主張しているもの。整数運動量では臨界点で等号が起こる）。

- `gamma_2_theta_tilde_nonzero`: `min |γ_2(θ~_μ)| = 3.5e-1`（0 から離れている）
- `gamma1_gt_1_theta_tilde`: `min (γ_1(θ~_μ) − 1) = 6.0e-2 > 0`（狭義）
- `def_gamma_theta_tilde_mu`: `min γ(θ~_μ) = 3.4e-1 > 0`（狭義）

### 数値的な注意（証明の内容とは無関係）

`check_03` の `T_V_plus_is_conjugation (3)(4)` は `(gh)^{-1} = h^{-1}g^{-1}` の検証だが、
これを `(gh).inverse()` と `h^{-1}g^{-1}` の直接比較で書くと残差 4e-8 になり閾値を割る。
`V_2` の前因子 `(2 s_2)^{M/2}` と `exp((i/2)K_1H_1^{(+)})` によって `gh` の条件数が
悪くなるためで、主張が偽なのではない。**「`h^{-1}g^{-1}` が `gh` の逆元である」という
主張の内容そのもの**、すなわち `(gh)(h^{-1}g^{-1}) = I` と `(h^{-1}g^{-1})(gh) = I` を
検証する形に直してある（残差 1e-13 台）。
