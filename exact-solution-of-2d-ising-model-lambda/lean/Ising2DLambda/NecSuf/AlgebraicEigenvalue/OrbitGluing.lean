/-
定義「軌道ごとの置換の組」「軌道ごとの置換の組の貼り合わせ」と主張
「貼り合わせは行配位の全体の上の全単射である」「貼り合わせは軌道を保つ置換である」
「貼り合わせの各軌道への制限はもとの組に一致する」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitGluing`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（同じ選び方・同じ 2 段の単射性・同じ逆像の取り方）。

  主張              使っている性質
  glue              各点 i にその点を含む集合 `blk i` が指定されていること（`hself`）だけ。
  glue_mem_block    同上。
  glue_bijective    上に加えて (a) `blk i` が族 𝒪 に属すること、(b) 族の元 O とその点 i について
                    `blk i = O` であること（＝**点がどの集合に属するかが一意であること**。
                    人手証明が「2 つの軌道は一致するか互いに素である」を使っている箇所）、
                    (c) 族の各元の上で組が全単射であること。
  restriction_glue  (b) だけ。

削れなかった仮定と、その理由。

1. `hself : ∀ i, i ∈ blk i`。貼り合わせを定めるのに要る（`i` を `blk i` の上の写像へ渡せない）。
2. `huniq : ∀ O ∈ 𝒪, ∀ i ∈ O, blk i = O`。**これが互いに素であることの中身である。**
   単射性で「行き先が一致するなら同じ集合の上で動かされている」を出す段と、
   制限がもとの組に戻る段の両方に要る。落とすと、族の元 O の上の制限が `blk i` の側の
   組の成分になってしまい `α O` に一致しない。
   人手証明では `claim_row_config_orbit_disjoint_or_eq` と `claim_row_config_orbit_mem_eq` が
   この役をしている。
3. `hblk : ∀ i, blk i ∈ 𝒪`（`glue_bijective` のみ）。全単射性の仮定 `hbij` を `blk i` へ
   当てるために要る。
4. `hbij : ∀ O ∈ 𝒪, Function.Bijective (α O)`。単射性は組の単射性から、全射性は組の全射性から出る。
   **族の元でない Finset について組が全単射であることは要求していない**（貼り合わせが触るのは
   `blk i` の成分だけである）。
5. `DecidableEq` は要らない（`Finset.image` を使わないため）。ι の有限性も要らない。

具体版との差で言えば、行配位であること・巡回シフト `S` があること・`blk` が軌道であること・
`Fintype ι` はいずれも使っていない。すなわちこの 3 つの主張は「各点に 1 つの集合を割り当てる
分割じみた族」と「その各元の上の全単射の組」についての言明であって、軌道の理論には属さない。

mathlib の `Equiv.Perm.subtypePerm` / `Finset.sigma` / 群作用の軌道の一般論は引いていない
（引くと「各点の属する集合の上の写像を当てる」という人手証明の定め方が既製の構成へ置き換わる）。

住処: ここに ℝ / ℂ は現れない（添字は一般の型）。
-/
import Mathlib.Data.Finset.Basic
import Mathlib.Logic.Equiv.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {ι : Type*}

/-- 人手証明の定義「軌道ごとの置換の組の貼り合わせ」`gl(α)(τ) = (α(O(τ)))(τ)`。

`blk i` が人手証明の `O(τ)` にあたる。ここで `blk i` が軌道であることは**使っていない**。 -/
def glue (α : ∀ O : Finset ι, {x : ι // x ∈ O} → {x : ι // x ∈ O}) (blk : ι → Finset ι)
    (hself : ∀ i : ι, i ∈ blk i) (i : ι) : ι :=
  (α (blk i) ⟨i, hself i⟩).1

/-- 人手証明の主張「貼り合わせは軌道を保つ置換である」の本体
（値が `blk i` に収まること。人手証明の 2 段の式変形そのもの）。 -/
theorem glue_mem_block (α : ∀ O : Finset ι, {x : ι // x ∈ O} → {x : ι // x ∈ O})
    (blk : ι → Finset ι) (hself : ∀ i : ι, i ∈ blk i) (i : ι) :
    glue α blk hself i ∈ blk i :=
  (α (blk i) ⟨i, hself i⟩).2

/-- 人手証明の主張「貼り合わせの各軌道への制限はもとの組に一致する」の本体。

点の属する集合が一意であること（`huniq`）だけを使う。 -/
theorem restriction_glue {α : ∀ O : Finset ι, {x : ι // x ∈ O} → {x : ι // x ∈ O}}
    {blk : ι → Finset ι} {hself : ∀ i : ι, i ∈ blk i} {𝒪 : Set (Finset ι)}
    (huniq : ∀ O ∈ 𝒪, ∀ i ∈ O, blk i = O)
    {O : Finset ι} (hO : O ∈ 𝒪) {i : ι} (hi : i ∈ O) :
    glue α blk hself i = (α O ⟨i, hi⟩).1 := by
  have hblkO : blk i = O := huniq O hO i hi
  subst hblkO
  rfl

/-- 人手証明の主張「貼り合わせは行配位の全体の上の全単射である」。

証明は人手証明どおり、単射性と全射性を別々に示す。
単射性は「行き先が一致するなら同じ集合の上で動かされている」を `huniq` から出し、
そのうえで組の単射性を当てる。全射性は組の全射性から逆像を 1 つ取る。 -/
theorem glue_bijective {α : ∀ O : Finset ι, {x : ι // x ∈ O} → {x : ι // x ∈ O}}
    {blk : ι → Finset ι} {hself : ∀ i : ι, i ∈ blk i} {𝒪 : Set (Finset ι)}
    (hblk : ∀ i : ι, blk i ∈ 𝒪)
    (huniq : ∀ O ∈ 𝒪, ∀ i ∈ O, blk i = O)
    (hbij : ∀ O ∈ 𝒪, Function.Bijective (α O)) :
    Function.Bijective (glue α blk hself) := by
  constructor
  · -- 単射性
    intro i₁ i₂ hi
    -- 行き先は blk i₁ にも blk i₂ にも属する（人手証明の τ₃ ∈ O(τ₁) ∩ O(τ₂)）
    have hv₁ : glue α blk hself i₁ ∈ blk i₁ := glue_mem_block α blk hself i₁
    have hv₂ : glue α blk hself i₁ ∈ blk i₂ := hi ▸ glue_mem_block α blk hself i₂
    -- したがって blk i₁ = blk i₂（人手証明が「互いに素」から出している段）
    have hblkeq : blk i₁ = blk i₂ := by
      have h₁ : blk (glue α blk hself i₁) = blk i₁ :=
        huniq (blk i₁) (hblk i₁) _ hv₁
      have h₂ : blk (glue α blk hself i₁) = blk i₂ :=
        huniq (blk i₂) (hblk i₂) _ hv₂
      rw [← h₁, h₂]
    -- 同じ集合 O := blk i₁ の上の組の単射性を当てる
    have hi₂ : i₂ ∈ blk i₁ := hblkeq ▸ hself i₂
    have e₁ : glue α blk hself i₁ = (α (blk i₁) ⟨i₁, hself i₁⟩).1 :=
      restriction_glue huniq (hblk i₁) (hself i₁)
    have e₂ : glue α blk hself i₂ = (α (blk i₁) ⟨i₂, hi₂⟩).1 :=
      restriction_glue huniq (hblk i₁) hi₂
    have hval : (α (blk i₁) ⟨i₁, hself i₁⟩) = (α (blk i₁) ⟨i₂, hi₂⟩) :=
      Subtype.ext (by rw [← e₁, ← e₂, hi])
    have := (hbij (blk i₁) (hblk i₁)).1 hval
    exact congrArg Subtype.val this
  · -- 全射性
    intro j
    obtain ⟨z, hz⟩ := (hbij (blk j) (hblk j)).2 ⟨j, hself j⟩
    refine ⟨z.1, ?_⟩
    have e : glue α blk hself z.1 = (α (blk j) ⟨z.1, z.2⟩).1 :=
      restriction_glue huniq (hblk j) z.2
    rw [e, Subtype.coe_eta, hz]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
