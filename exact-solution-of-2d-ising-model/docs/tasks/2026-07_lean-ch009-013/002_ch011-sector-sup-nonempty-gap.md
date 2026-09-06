# 章 011 `sector_decomposition_of_rayleigh_sup` (3): `c_±(M)` の上限が定義できることが未確認

- 対象: `structured-latex/content/011_max_eigenvalue.ts`
  / `maxeig_010_claim_sector_decomposition_of_c`（ラベル `sector_decomposition_of_rayleigh_sup`）(3)
- 発見経緯: Lean 形式化（`lean/Ising2D/Part011/Claim010_SectorDecomposition.lean`）
- 影響: 結論 `c(M) = max(c₊(M), c₋(M))` は正しい。**穴は「`c_±(M)` が定義できること」の根拠が
  本文に無い**点である。

## 何が抜けているか

本文は

```
c_±(M) := sup { xᵀWx | x ∈ F^{(±)} ∩ ℝ^{2^M}, ‖x‖ = 1 }
```

と定義しているが、`def_rayleigh_sup` で `c(M)` について明示していた
「集合が空でないこと」「上に有界であること」の 2 点を、`c_±(M)` については述べていない。

- 上に有界であることは `𝓡_± ⊆ 𝓡` なので `c(M)` の有界性からただちに従う（軽微）。
- **空でないこと（`F^{(±)}` に単位ベクトルが存在すること）は本文のどこでも示されていない。**
  実際には `ε` が非自明な対合なので `F^{(+)}`, `F^{(-)}` はいずれも `2^{M-1}` 次元だが、
  本文はその事実を（章 009 でも）述べていない。

証明の最後の段「`F^{(±)}` の単位ベクトルは `ℝ^{2^M}` の単位ベクトルでもあるので
`c_± ≤ c(M)`」も、単位ベクトルの存在を暗黙に使っている。

## Lean での扱い

Lean（mathlib）では `sSup ∅ = 0` という規約があるので、セクターが空でも
`sectorRayleighSup` は well-defined になる。そこで
`Ising2D.sectorRayleighSup_le` は空の場合を明示的に場合分けし、
空なら `sSup ∅ = 0 ≤ c(M)`（`rayleighSup_nonneg` による）として処理している。

```lean
theorem sectorRayleighSup_le ... : sectorRayleighSup W ε s ≤ rayleighSup W := by
  rcases Set.eq_empty_or_nonempty (sectorSet W ε s) with hemp | hne
  · rw [sectorRayleighSup, hemp, Real.sSup_empty]
    exact rayleighSup_nonneg hW hpsd
  · ...
```

したがって **Lean 側の定理 `Ising2D.sector_decomposition_of_rayleigh_sup` は
セクターが空でも成り立つ形**になっており、本文の穴に依存していない。
ただし本文は `sup` の存在を明示する流儀を採っている（`def_rayleigh_sup` 参照）ので、
同じ流儀を保つなら `F^{(±)} ≠ {0}` を述べる必要がある。

## 提案する修正（本文の修正は別セッション担当）

(3) の直前に「`F^{(±)}` はいずれも `{0}` ではない（`P^{(±)}` の像が非自明）」ことを
一言足し、`𝓡_±` が空でなく上に有界であること（後者は `𝓡_± ⊆ 𝓡`）を明示する。

## 併記: (2) の Lean 接続に残る一単位

同 claim の (2) `W P^{(±)} = V^{(±)} P^{(±)}` について、`V_1` の固有空間制限と
下流のセクター置換は形式化済みである。章 011 の実行列 `W` と、章 010 の Pauli 表示から作る
複素 `TensorPow` 上の物理的転送行列の同一視も `Ising2D.physicalSymTransferC_eq_map` で形式化した。
残るのは、この同一視を既存の `Vsym` と `epsProj` へ接続して射影後の等式を閉じる最終定理である。
(1) と (3) は形式化済み。
