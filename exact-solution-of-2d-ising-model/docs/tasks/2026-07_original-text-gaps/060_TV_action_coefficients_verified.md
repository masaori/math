# `T_V_hatZ_hatY` 周辺の係数の独立検算 — **原文の誤りは無かった**

**現況: 穴なし。本文の修正は不要。**（調査日 2026-07-26）

`T_V_hatZ_hatY` を「仮定つきの定理」から「無条件の定理」へ閉じる作業
（Lean 側の `Ising2D/Part008/Claim012_TVActions.lean`）の過程で、原文
`008_TV1_hatZ_hatY_part1.ts` の 4 ブロックの係数を**原文を見ずに独立に導出して
突き合わせた**。結果、**原文の値はすべて正しかった**。

このファイルは「検算したが穴は無かった」という否定的結果の記録である
（同じ箇所を再調査する二重作業を防ぐために残す）。

## 対象ブロック

| `id` | `labels` |
| --- | --- |
| `TV1_hatZ_hatY_002_claim_nesting_commutator` | `nesting_of_commutator_of_H_and_Z` |
| `TV1_hatZ_hatY_005_claim_extract_taylor_coefficient` | `extract_taylor_coefficient_of_Z_Y` |
| `TV1_hatZ_hatY_012_claim_TV1_TV2_actions` | `ホロノミック量子場_p142下段_1` |
| `TV1_hatZ_hatY_018_claim_T_V_action` | `T_V_hatZ_hatY` |

## (1) 何を検算したか

原文は「入れ子交換子を偶奇で場合分け（`002`）→ その係数を cosh / sinh のテイラー級数と
突き合わせ（`005`）→ 作用行列 `B_1(θ_μ)`, `B_2` を読み取る（`012`）」という 3 段で
進む。Lean 側ではこれを

- `ad X` が `span{Ẑ_μ^{(-)}, Ŷ_μ}` を保つこと（`ad X z = α y`, `ad X y = β z`）
- そのときの閉じた形 `exp(X) z exp(-X) = cosh(s) z + α sinhc(s) y`
  （`s^2 = αβ`、`Ising2D.matExp_conj_two_dim_z` / `..._y`。既に形式化済み）

の 2 段に置き換えて、`α, β, s` を `<commutator_of_H_and_Z_Y>` の (1)(3)(4)(6) から
**独立に計算した**。

## (2) 導出した値と原文の値の対応

`θ_μ := 2πμ/M`、`e^{-iθ_μ}` は Lean の `expPhase M μ`。

### `X_1 = (1/2) i K_1 H_1^{(-)}`（`V_1^{1/2}` の指数の中身）

原文 (1) `[H_1^{(±)}, Ẑ_μ^{(±)}] = 2 e^{-iθ_μ} Ŷ_μ` と (3) `[H_1^{(±)}, Ŷ_μ] = -2 e^{iθ_μ} Ẑ_μ^{(±)}` より

```
α_1 = (1/2) i K_1 · 2 e^{-iθ_μ} =  i K_1 e^{-iθ_μ}
β_1 = (1/2) i K_1 · (-2 e^{iθ_μ}) = -i K_1 e^{iθ_μ}
α_1 β_1 = -i^2 K_1^2 (e^{-iθ_μ} e^{iθ_μ}) = K_1^2   ⟹  s = K_1
```

したがって

```
α_1 sinhc(K_1) = i e^{-iθ_μ} (K_1 sinhc K_1) =  i e^{-iθ_μ} sinh K_1
β_1 sinhc(K_1) =                              -i e^{ iθ_μ} sinh K_1
```

原文 `005` (h1.z) の `cosh(K_1)Ẑ + i e^{-i2πμ/M} sinh(K_1)Ŷ`、
(h1.y) の `-i e^{i2πμ/M} sinh(K_1)Ẑ + cosh(K_1)Ŷ`、および `018` の

```
B_1(θ_μ) = ( cosh K_1                -i e^{ iθ_μ} sinh K_1 )
           ( i e^{-iθ_μ} sinh K_1     cosh K_1             )
```

と**完全に一致する**。

### `X_2 = i K_2^* H_2`（`V_2` の指数の中身）

原文 (4) `[H_2, Ẑ_μ^{(-)}] = -2 Ŷ_μ` と (6) `[H_2, Ŷ_μ] = 2 Ẑ_μ^{(-)}` より

```
α_2 = i K_2^* · (-2) = -2 i K_2^*
β_2 = i K_2^* ·   2  =  2 i K_2^*
α_2 β_2 = 4 K_2^{*2} = (2K_2^*)^2   ⟹  s = 2 K_2^*
α_2 sinhc(2K_2^*) = -i sinh(2K_2^*),   β_2 sinhc(2K_2^*) = i sinh(2K_2^*)
```

原文 `005` (h2.z−)(h2.y) と `018` の

```
B_2 = ( cosh 2K_2^*         i sinh 2K_2^* )
      ( -i sinh 2K_2^*      cosh 2K_2^*   )
```

と**完全に一致する**。

### `V_2` のスカラー因子

原文は `V_2 = (2s_2)^{M/2} exp(i K_2^* H_2)` のスカラー因子を「共役で打ち消し合う」として
落としている。これは任意の ℂ-代数で成り立つ等式 `(c g) a (c⁻¹ g⁻¹) = g a g⁻¹` であり、
**正しい**（`s_2 > 0` より `(2s_2)^{M/2} ≠ 0` が要ることだけは原文が
`def_transfer_matrix_symbols` 末尾の「`K_i > 0` より `s_i > 0`」で担保している）。

### 符号の選択

原文 `012` の proof は「本主張では `Ẑ_μ^{(-)}` に作用させるので、`±` はいずれも `-`
（`H_1^{(-)}` と `Ẑ_μ^{(-)}` の組）を選ぶ」と明記している。この選択は必要かつ十分で、
**偽であることが判明している (2)(5)**（逆符号の組についての式。
`lean/Ising2D/Part008/Claim001_CommutatorHZY.lean` 冒頭参照）は
この経路では一度も使われない。したがって (2)(5) の誤りは `T_V_hatZ_hatY` に波及しない。

## (3) 検算の根拠（Lean の定理名）

すべて `lake build` と `bash scripts/check-no-sorry.sh` を通っている（`sorry` / `admit` ゼロ）。

| 内容 | Lean |
| --- | --- |
| `ad X_1`, `ad X_2` が `span{Ẑ^{(-)}, Ŷ}` を保つこと | `Ising2D.ad_V1half_hatZMinus` / `ad_V1half_hatY` / `ad_V2_hatZMinus` / `ad_V2_hatY` |
| 抽象版の作用行列 `!![cosh s, β sinhc s; α sinhc s, cosh s]` | `Ising2D.Abstract.twoDimConjMat` / `Abstract.exp_conj_two_dim_actsBy` |
| **導出した係数が原文の `B_1(θ)`, `B_2` に一致すること** | `Ising2D.B1mat_eq_twoDimConjMat` / `Ising2D.B2mat_eq_twoDimConjMat` |
| スカラー因子が共役で打ち消えること | `Ising2D.Abstract.conj_smul_eq` / `Ising2D.actsBy_TConj_smulUnits` |
| 原文 `012` の 4 式（かつては仮定、現在は定理） | `Ising2D.actsBy_TConj_V1half` / `Ising2D.actsBy_TConj_V2` |
| 原文 `018` `T_V_hatZ_hatY`（無条件版） | `Ising2D.TV_hatZ_hatY` |
| 原文 `031` `commutation_V_psi`（無条件版） | `Ising2D.TV_psiDag` / `TV_psi` / `TV_psiDag_psi` |

## 付随して残っている前提（既知。新規の穴ではない）

`B_1(θ_μ) B_2 B_1(θ_μ) = A(θ_μ)` には双対関係の帰結 `s_2^* c_2 = c_2^*` が要る。
これは既知の指摘で、`030_det_A_theta_duality.md` と
`lean/Ising2D/Part008/Definition016_TV.lean` 冒頭に記録済みである。
Lean では `hdual` として明示の仮定に持ち上げてある（`Ising2D.TV_hatZ_hatY` の引数）。
