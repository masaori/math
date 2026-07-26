# SageMath Check: 049_claim_even_sector_fermions

## 対象

**対象ラベル**: `V_plus_eq_c_check_Vprime` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/016_even_sector_fermions.ts`
- 併せて検証（この章の全ブロック）:
  - `def_check_fermi`（半整数運動量のフェルミオン `ψ̌_μ, ψ̌_μ^†`）
  - `periodicity_of_check_fermi`（`M` 周期性と共役添字 `1−μ`）
  - `anticommutator_of_check_psi`（**対になる添字は `μ+ν ≡ 1 (mod M)`**）
  - `commutation_V_plus_check_psi`（`T_{(V^{(+)})}(ψ̌_μ^†) = e^{+γ(θ~_μ)} ψ̌_μ^†` 等）
  - `def_check_Vprime`（`V̌' = exp(Σ_{μ=1}^{M} γ(θ~_μ)(ψ̌_μ^† ψ̌_{1−μ} − I/2))`）
  - `action_of_T_check_Vprime_on_check_psi`（`T_{(V̌')}` の `ψ̌` への作用）
  - `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` / `T_V_plus_eq_T_check_Vprime`
  - `V_plus_eq_c_check_Vprime`（`V^{(+)} = c V̌'`）

### 何を確定させるための検証か

章 C′（偶セクターの半整数運動量モード）の C′-13・C′-14 にあたる。
008 章は整数運動量 `θ_μ = 2πμ/M` について同じ道筋（フェルミオン → `V'` → `V = cV'`）を
辿っているが、そこでは次の 2 点で例外処理が必要だった。

1. 臨界点 `sinh 2K_1 sinh 2K_2 = 1` かつ `μ = ±M` で `γ_2(θ_μ) = 0` になり、
   `ψ_μ, ψ_μ^†` が定義できない（`def_fermi` の定義域限定、`def_Vprime` の和の範囲限定、
   `A_theta_is_identity_when_gamma2_zero` / `T_Vprime_fixes_hatZ_hatY_when_gamma2_zero` による別扱い）。
2. `ψ` の係数に複素平方根 `√(γ_2(θ_μ)γ_2(−θ_μ))` が現れるため、反交換関係の証明で
   `μ` と `ν` の分枝の一致（`anticommutator_of_psi` の Step 0）を別途示す必要があった。

**この検証の主眼は、半整数運動量ではどちらも起こらないことを数値で固定することにある。**
そのうえで、本章の各段（反交換関係・`V^{(+)}` の作用・`V̌'` の作用・`T` の一致・`V^{(+)} = cV̌'`）を
**ラベル単位で個別に**確かめる。

## 検証の枠組み

`_prelude.sage` に、`_shared/spin_ops.sage`（`Z_j, Y_j, H_1^{(±)}, H_2` の明示行列）の上へ
半整数運動量の道具を積む。

```
θ~_μ    = 2π(μ − 1/2)/M
Ž_μ     = Σ_{j=1}^{M} Z_j e^{−ijθ~_μ},   Y̌_μ = Σ_{j=1}^{M} Y_j e^{−ijθ~_μ}
γ_1(θ)  = c_1 c_2* − s_1 s_2* cos θ,     γ_2(θ) = i e^{iθ} s_2* (c_1 cos θ − i sin θ − s_1 c_2)
γ(θ~_μ) = arccosh(γ_1(θ~_μ))
P̌_μ     = [[ −r/(2√M b), +r/(2√M b) ], [ 1/(2√M), 1/(2√M) ]]   (r = |γ_2(θ~_μ)|, b = γ_2(−θ~_μ))
(ψ̌_μ^†, ψ̌_μ) := (Ž_μ, Y̌_μ) P̌_μ
X̌       = Σ_{μ=1}^{M} γ(θ~_μ)(ψ̌_μ^† ψ̌_{1−μ} − I/2),   V̌' = exp(X̌)
V^{(+)}  = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}
```

`V^{(+)}` と `V̌'` はいずれも**行列指数関数から直接構成する**（証明が使う交換子の級数展開とは
独立な経路）。`V_2` の前因子 `(2 s_2)^{M/2}` も明示的に付けてある。

パラメータ:

- `M = 2, 3, 4, 5`、`μ ∈ {1,…,M}` に加えて `μ = 0, −1, M+1` 等（主張が `μ ∈ ℤ` 全体であることの確認）
- `(K_1, K_2)` は 6 組。**厳密な臨界点**（`K_2 = arcsinh(1/sinh 2K_1)/2` で構成）2 組
  （非等方・等方 `K_1 = K_2 = K_c`）、臨界点近傍 1 組、一般点 2 組、高温側 1 組。

判定閾値は `TOL = 1e-8`（`report()` で最大残差と比較）。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_def_and_periodicity.sage | `def_check_fermi` の定義式が `(Ž_μ, Y̌_μ)P̌_μ` の 2 列に一致すること、**分母 `2√M γ_2(−θ~_μ)` が全 `μ`・全 `K` で 0 から離れている（＝定義域に例外が無い）** こと、`periodicity_of_check_fermi` (1)(2)(3) | PASS | 残差 ≤ 2.8e-14、分母の全体最小 `2.53e0` |
| 02 | check_02_anticommutator.sage | `anticommutator_of_check_psi` の 3 式。`δ^M_{(μ+ν,1)} = 1` の場合と `0` の場合を別集計。**対照として対を `μ+ν ≡ 0 (mod M)` と誤ると残差 1.0 で不成立になることも示す** | PASS | 残差 ≤ 2.0e-15、誤った対の残差 `1.0e0` |
| 03 | check_03_V_plus_action.sage | `commutation_V_plus_check_psi`。前提の (a) `T_V_plus_check_Z_Y`、(b) `A(θ~_μ)P̌_μ = P̌_μ Ď_μ` も個別に確認 | PASS | 残差 ≤ 8.4e-11 |
| 04 | check_04_Vprime_action.sage | `def_check_Vprime`（`V̌'(V̌')^{-1} = I`）、`action_of_T_check_Vprime_on_check_psi`、および proof の中間段 `[X̌, ψ̌_μ^†] = +γψ̌_μ^†` / `[X̌, ψ̌_μ] = −γψ̌_μ`。**和の範囲を `{1..M−1}` に狭めても `{1..M+1}` に広げても中間段が壊れることを示し、`μ = 1..M` に数え落としも重複も無いことを裏づける** | PASS | 残差 ≤ 1.7e-11、範囲を変えた場合の残差 `4.7e0` |
| 05 | check_05_T_equality.sage | 復元公式 `Z_m, Y_m = (1/M)Σ_μ Ž_μ/Y̌_μ e^{imθ~_μ}`、(a) `Ž_μ, Y̌_μ` 上での一致、(b) `Z_m, Y_m` 上での一致、(c) **行列単位 `e_{ij}`（`2^M × 2^M` 個）すべてで一致**（＝ `T_V_plus_eq_T_check_Vprime` の結論そのもの） | PASS | 残差 ≤ 5.4e-9 |
| 06 | check_06_V_eq_cVprime.sage | `W := (V̌')^{-1}V^{(+)}` がスカラー行列であること、`V^{(+)} − cV̌' = O`、`c ≠ 0`。参考として `c = (2 sinh 2K_2)^{M/2}` との一致（**この等式の証明は本章では行わない。次章の内容**） | PASS | 残差 ≤ 9.8e-12、`min\|c\| = 1.03e-1`、`c` の相対差 ≤ 2.3e-13 |

## 結論

- 半整数運動量では `γ_2(θ~_μ) ≠ 0` が例外なく成り立つため、`ψ̌_μ, ψ̌_μ^†` は **すべての `μ ∈ ℤ`** で
  定義でき、`V̌'` の和も `μ = 1,…,M` を例外なく走る（check_01, check_04）。
  008 章が必要としていた臨界点の場合分けは、偶セクターでは一つも要らない。
- 反交換関係の対は `μ+ν ≡ 1 (mod M)` である。`μ+ν ≡ 0` ではない（check_02 の対照）。
- `T_{(V^{(+)})} = T_{(V̌')}` が `Mat(2^M,ℂ)` 全体で成り立ち、`V^{(+)} = cV̌'`（`c ∈ ℂ^×`）が従う
  （check_05, check_06）。
- `c` の実測値は全ケースで `(2 sinh 2K_2)^{M/2}` に一致した（相対差 ≤ 2.3e-13）。
  ただし **この等式の証明は 016 章の範囲外**であり、次章（017）で扱う。

## μ の量化範囲の絞り込み（2026-07-27）

`def_check_fermi` / `anticommutator_of_check_psi` / `commutation_V_plus_check_psi` /
`def_check_Vprime` / `action_of_T_check_Vprime_on_check_psi` の量化範囲を
`μ ∈ ℤ` から `𝓜̌ = {1,…,M}`（`def_check_index_set`）へ絞り、`X̌` の共役添字を
`ψ̌_{1−μ}` から `ψ̌_{M+1−μ}` へ書き換えたのに合わせて `_prelude.sage` /
check_01 / check_04 を更新し、**再実行した**（`run-log.txt` はその出力）。

`periodicity_of_check_fermi` は内容を組み替えた：以前の (2)（`ψ̌_{μ+kM} = ψ̌_μ`）は、
共役添字の書き換えにより `𝓜̌` の外で `ψ̌` を評価する箇所が本文から消えたため不要になり、
代わりに (1) `γ_1, γ_2` の `2π` 周期性（`θ ∈ ℝ`）と (3) 共役添字 `M+1−μ` での関係を置いた。
`μ ∈ ℤ` で量化するのは (2)（`γ_1, γ_2` の `θ~_{μ+kM}` での値）だけである。

## 実行

```bash
cd sagemath/check/049_claim_even_sector_fermions
for f in check_0*.sage; do /usr/local/bin/sage "$f"; done
```

実行出力は `run-log.txt`。
