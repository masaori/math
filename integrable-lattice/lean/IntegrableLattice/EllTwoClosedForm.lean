/-
# 定理 Y′（$\ell=2$・族 $p(1,0)+q(0,1)$ の閉形式、4 場合分け）— cycle 20 step 3

対応する人手証明:

* 根拠 report: `outputs/reports/cycle20_T3_ell_equals_2.md` §2（場合分け）・§5.2（定理 Y′ $(5.4)$）・
  §5.3（系 Y″）
* 本文（構造化テキスト）側は cycle 21 step 4 が反映予定（本ファイル作成時点では未反映）。

## 目的

**証明の正しさではなく、主張の検算**である。定理 Y′ は 4 つの場合それぞれで
$\mathrm{ord}_2(\kappa_n)$ の閉形式を与える。ここで検査するのは
**場合分けが排反かつ網羅か**、**$n=1$ の但し書きが一意に読めるか**、
**系 Y″（定理 X′ が正しいのは case B かつ $\lambda_1\ge2$ のときちょうど）の根拠づけが十分か**である。

## 形式化した主張

* `ordKappaAalpha` / `ordKappaAbeta` / `ordKappaB` / `ordKappaBsat` — $(5.4)$ の 4 行。
* `ordKappaXprime` — 比較対象（cycle 19 step 2 定理 X′ を $\ell=2$ に当てたもの）。
* `Aalpha_seq` / `Abeta_seq` / `Bsat_seq` / `B_seq` — report §5.2 注 5.1 が挙げる
  4 つの数列（$n=1..6$）を `norm_num` で再計算し、**4 数列が相異なる**ことも確認。
* `caseA_or_caseB` / `not_caseA_and_caseB` / `lam0_ge_one` / `w_ge_one_of_lam1_one` —
  場合分けが排反・網羅であること、および $\lambda_0\ge1$・$(\lambda_1=1\Rightarrow w\ge1)$。
* `Bsat_one_eq_B_one_add` / `Bsat_ne_B_at_one` — **$n=1$ の但し書きが必要な理由**
  （case B・$\lambda_1=1$ では第 4 行は $n=1$ で真値より $2w$ だけ大きい）。
* `Aalpha_one_eq_B_one` / `Abeta_one_eq_B_one` — **case A では但し書きが冗長であること**
  （$\lambda_1$ を $\lambda_0$ と読めば第 3 行の $n=1$ は第 1・2 行から従う）。
* `B_eq_Xprime` — 系 Y″ の成立側。
* `Aalpha_eq_Xprime_at_one_two` / `Aalpha_ne_Xprime_at_three` — 系 Y″ の**不成立側の根拠**。

## 形式化で分かったこと（本文・report との食い違い）

1. **$(5.4)$ の第 3 行の但し書き「および全ての場合の $n=1$」は、そのままでは読めない。**
   第 3 行は $\lambda_1$（case B の偶側係数の $2$ 進付値）を含むが、
   **case A では $\lambda_1$ が定義されていない**。したがって
   「全ての場合の $n=1$」を case A に当てようとすると値が決まらない。
   実際に必要なのは **case B かつ $\lambda_1=1$ の $n=1$** だけである
   （`Bsat_ne_B_at_one`: 第 4 行を $n=1$ に当てると $2w$ だけずれる。
   $\lambda_1=1$ のとき $w\ge1$ なので必ずずれる）。
   case A については、$\lambda_1$ を $\lambda_0$ と読み替えれば第 3 行の $n=1$ の値は
   第 1・2 行から**従う**（`Aalpha_one_eq_B_one`・`Abeta_one_eq_B_one`）ので、
   但し書きは冗長である。**「必要な場合」と「冗長な場合」が 1 つの但し書きに混ざっている。**
2. **系 Y″ の証明の「実際 $n=1,2$ の 2 点で既に食い違う」は、$\Lambda$ を動かすと成り立たない。**
   case A$\alpha$ の数列は、$\Lambda=1$ とした定理 X′ の式と
   **$n=1$ でも $n=2$ でも一致する**（`Aalpha_eq_Xprime_at_one_two`: $5,19$）。
   食い違いが出るのは $n=3$（$61$ vs $55$）である（`Aalpha_ne_Xprime_at_three`）。
   系 Y″ の主張自体は正しい（$\Lambda$ は塔から決まる量で、A$\alpha$ では $\Lambda=2$ なので
   $n=1$ で $6\neq5$）が、**「2 点で既に食い違う」という根拠づけは $\Lambda$ が固定されている
   ことに依存しており、そのままでは一般の $\Lambda$ に対する反証にならない。**
   $\Lambda$ を動かして反証するには $n\le3$ の 3 点が要る。
3. case B・$\lambda_1=1$、および case A$\beta$ については、$\Lambda$ を動かしても
   $n\le2$ の 2 点で食い違う（`Bsat_ne_Xprime_at_two` / `Abeta_ne_Xprime_at_two`）。
   すなわち **3 点が要るのは A$\alpha$ だけ**である。

## 形式化しなかったもの（理由）

* $(5.4)$ の**導出**（レベルごとの和 $S_m$、補題 Y4 の場合分け、$\varphi_m$ で割る段）。
  これには $\mathbb{Q}(\zeta_{2^m})$ の $2$ の上の素点での付値が要る。
  円分体（`IsCyclotomicExtension`）も付値も **mathlib に在る**ので欠落ではなく**配線**である
  （`lean/logs/mathlib-gap-survey-cycle21.log`）。本ファイルは閉形式の**形と場合分け**だけを検算する。
* 塔の値 $\kappa_n$ の独立計算には Kirchhoff の matrix-tree 定理が要り、これは
  **mathlib に無い**（cycle 16・20 の調査と本サイクルの再調査で一致）。
  数値照合は Lean の外（`lean/logs/ell2-matrix-tree-cycle21.log`）で行った。
-/
import Mathlib

namespace IntegrableLattice
namespace EllTwo

/-! ## $(5.4)$ の 4 行と、比較対象の定理 X′ -/

/-- $(5.4)$ 第 1 行。case A$\alpha$（$p',q'$ ともに奇、$\lambda_0=v_2(p'+q')=1$）。 -/
def ordKappaAalpha (mu n : ℕ) : ℤ :=
  (mu : ℤ) * (4 ^ n - 1) + 2 * n * 2 ^ n + 4 * 2 ^ n - 6 * n - 1

/-- $(5.4)$ 第 2 行。case A$\beta$（ともに奇、$\lambda_0\ge2$）。 -/
def ordKappaAbeta (mu lam0 n : ℕ) : ℤ :=
  (mu : ℤ) * (4 ^ n - 1) + 2 * n * 2 ^ n + 2 * lam0 * 2 ^ n - 2 * n - 3 * lam0 + 2

/-- $(5.4)$ 第 3 行。case B（一方が偶）で $\lambda_1=v_2(c_e)\ge2$。 -/
def ordKappaB (mu lam1 n : ℕ) : ℤ :=
  (mu : ℤ) * (4 ^ n - 1) + 2 * n * 2 ^ n + lam1 * (2 ^ n - 1)

/-- $(5.4)$ 第 4 行。case B で $\lambda_1=1$、$n\ge2$（飽和・打ち消しの枝。$w$ が要る）。 -/
def ordKappaBsat (mu w n : ℕ) : ℤ :=
  (mu : ℤ) * (4 ^ n - 1) + 2 * n * 2 ^ n + 2 * n - 1 + 2 * w

/-- cycle 19 step 2 定理 X′ の閉形式を $\ell=2$ に当てたもの。 -/
def ordKappaXprime (mu Lam n : ℕ) : ℤ :=
  (mu : ℤ) * (4 ^ n - 1) + 2 * n * 2 ^ n + Lam * (2 ^ n - 1)

/-! ## report §5.2 注 5.1 の 4 数列（$n=1,\dots,6$） -/

/-- $(p,q)=(1,1)$: case A$\alpha$。 -/
theorem Aalpha_seq :
    (List.map (fun n => ordKappaAalpha 0 n) [1, 2, 3, 4, 5, 6]) = [5, 19, 61, 167, 417, 987] := by
  norm_num [ordKappaAalpha]

/-- $(p,q)=(1,3)$: case A$\beta$、$\lambda_0=2$。 -/
theorem Abeta_seq :
    (List.map (fun n => ordKappaAbeta 0 2 n) [1, 2, 3, 4, 5, 6]) = [6, 24, 70, 180, 434, 1008] := by
  norm_num [ordKappaAbeta]

/-- $(p,q)=(1,2)$: case B、$\lambda_1=1$、$w=1$。$n=1$ は第 3 行、$n\ge2$ は第 4 行。 -/
theorem Bsat_seq :
    ordKappaB 0 1 1 = 5 ∧
      (List.map (fun n => ordKappaBsat 0 1 n) [2, 3, 4, 5, 6]) = [21, 55, 137, 331, 781] := by
  constructor
  · norm_num [ordKappaB]
  · norm_num [ordKappaBsat]

/-- $(p,q)=(1,4)$: case B、$\lambda_1=2$。 -/
theorem B_seq :
    (List.map (fun n => ordKappaB 0 2 n) [1, 2, 3, 4, 5, 6]) = [6, 22, 62, 158, 382, 894] := by
  norm_num [ordKappaB]

/-- 4 つの数列は互いに異なる（$n=3$ で既に 4 値がすべて相異なる）。 -/
theorem four_cases_distinct_at_three :
    ordKappaAalpha 0 3 = 61 ∧ ordKappaAbeta 0 2 3 = 70 ∧
      ordKappaBsat 0 1 3 = 55 ∧ ordKappaB 0 2 3 = 62 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;>
    norm_num [ordKappaAalpha, ordKappaAbeta, ordKappaBsat, ordKappaB]

/-! ## 場合分けが排反かつ網羅であること -/

/-- $E=2^{-\mu}D$ の係数 $p',q'$ は同時に偶にならない（$\mu$ の定義）。
その下で case A（ともに奇）と case B（一方が偶）は**網羅**である。 -/
theorem caseA_or_caseB {p' q' : ℕ} (h : ¬(Even p' ∧ Even q')) :
    (Odd p' ∧ Odd q') ∨ (Even p' ∧ Odd q') ∨ (Odd p' ∧ Even q') := by
  rcases Nat.even_or_odd p' with hp | hp <;> rcases Nat.even_or_odd q' with hq | hq
  · exact absurd ⟨hp, hq⟩ h
  · exact Or.inr (Or.inl ⟨hp, hq⟩)
  · exact Or.inr (Or.inr ⟨hp, hq⟩)
  · exact Or.inl ⟨hp, hq⟩

/-- case A と case B は**排反**である。 -/
theorem not_caseA_and_caseB {p' q' : ℕ} :
    ¬((Odd p' ∧ Odd q') ∧ ((Even p' ∧ Odd q') ∨ (Odd p' ∧ Even q'))) := by
  rintro ⟨⟨hp, hq⟩, (⟨hp', _⟩ | ⟨_, hq'⟩)⟩
  · exact (Nat.not_even_iff_odd.mpr hp) hp'
  · exact (Nat.not_even_iff_odd.mpr hq) hq'

/-- case A では $\lambda_0=v_2(p'+q')\ge1$（$p'+q'$ は偶）。 -/
theorem lam0_ge_one {p' q' : ℕ} (hp : Odd p') (hq : Odd q') : 2 ∣ (p' + q') := by
  obtain ⟨a, rfl⟩ := hp
  obtain ⟨b, rfl⟩ := hq
  exact ⟨a + b + 1, by ring⟩

/-- case B で $\lambda_1=1$ なら $w=v_2(c_e/2+c_o)\ge1$
（report §2 の括弧書き「$c_e/2$ は奇なので $c_e/2+c_o$ は偶」の検算）。 -/
theorem w_ge_one_of_lam1_one {ce2 co : ℕ} (h1 : Odd ce2) (h2 : Odd co) : 2 ∣ (ce2 + co) := by
  obtain ⟨a, rfl⟩ := h1
  obtain ⟨b, rfl⟩ := h2
  exact ⟨a + b + 1, by ring⟩

/-! ## $n=1$ の但し書き（$(5.4)$ 第 3 行の「および全ての場合の $n=1$」） -/

/-- 第 4 行を $n=1$ に当てると、第 3 行（$\lambda_1=1$）より $2w$ だけ大きい。 -/
theorem Bsat_one_eq_B_one_add (mu w : ℕ) :
    ordKappaBsat mu w 1 = ordKappaB mu 1 1 + 2 * w := by
  simp [ordKappaBsat, ordKappaB]
  ring

/-- **但し書きが必要な唯一の場合**: case B・$\lambda_1=1$（このとき $w\ge1$）では
第 4 行は $n=1$ で誤った値を与える。 -/
theorem Bsat_ne_B_at_one (mu w : ℕ) (hw : 1 ≤ w) :
    ordKappaBsat mu w 1 ≠ ordKappaB mu 1 1 := by
  rw [Bsat_one_eq_B_one_add]
  have : (0 : ℤ) < 2 * w := by positivity
  omega

/-- **case A$\alpha$ では但し書きは冗長**: 第 3 行の $\lambda_1$ を $\lambda_0=1$ と読めば、
$n=1$ の値は第 1 行から従う。 -/
theorem Aalpha_one_eq_B_one (mu : ℕ) : ordKappaAalpha mu 1 = ordKappaB mu 1 1 := by
  simp [ordKappaAalpha, ordKappaB]
  omega

/-- **case A$\beta$ でも但し書きは冗長**: 第 3 行の $\lambda_1$ を $\lambda_0$ と読めば、
$n=1$ の値は第 2 行から従う（$\lambda_0$ について一様に）。 -/
theorem Abeta_one_eq_B_one (mu lam0 : ℕ) : ordKappaAbeta mu lam0 1 = ordKappaB mu lam0 1 := by
  simp [ordKappaAbeta, ordKappaB]
  ring

/-! ## 系 Y″（定理 X′ が $\ell=2$ で正しい範囲） -/

/-- 成立側: case B・$\lambda_1\ge2$ では $(5.4)$ 第 3 行は定理 X′ の式そのものである
（$\Lambda=\lambda_1$）。$\lambda_1\ge2$ は等式そのものには効かない。 -/
theorem B_eq_Xprime (mu lam1 n : ℕ) : ordKappaB mu lam1 n = ordKappaXprime mu lam1 n := rfl

/-- **系 Y″ の証明の但し書きへの反例**: case A$\alpha$ の数列は、
$\Lambda=1$ とした定理 X′ の式と $n=1,2$ の**両方で一致する**。
したがって「$n=1,2$ の 2 点で既に食い違う」は $\Lambda$ を動かすと成り立たない。 -/
theorem Aalpha_eq_Xprime_at_one_two :
    ordKappaAalpha 0 1 = ordKappaXprime 0 1 1 ∧ ordKappaAalpha 0 2 = ordKappaXprime 0 1 2 := by
  constructor <;> norm_num [ordKappaAalpha, ordKappaXprime]

/-- $\Lambda$ を動かして case A$\alpha$ を反証するには $n=3$ が要る
（$n=1$ で一致させると $\Lambda=1$ に決まり、$n=2$ でも一致してしまう）。 -/
theorem Aalpha_ne_Xprime_at_three (Lam : ℕ) (h : ordKappaAalpha 0 1 = ordKappaXprime 0 Lam 1) :
    ordKappaAalpha 0 3 ≠ ordKappaXprime 0 Lam 3 := by
  have hLam : (Lam : ℤ) = 1 := by
    simp [ordKappaAalpha, ordKappaXprime] at h
    omega
  simp [ordKappaAalpha, ordKappaXprime, hLam]

/-- case A$\beta$（$\lambda_0=2$）は $n\le2$ の 2 点で反証できる。 -/
theorem Abeta_ne_Xprime_at_two (Lam : ℕ) (h : ordKappaAbeta 0 2 1 = ordKappaXprime 0 Lam 1) :
    ordKappaAbeta 0 2 2 ≠ ordKappaXprime 0 Lam 2 := by
  have hLam : (Lam : ℤ) = 2 := by
    simp [ordKappaAbeta, ordKappaXprime] at h
    omega
  simp [ordKappaAbeta, ordKappaXprime, hLam]

/-- case B・$\lambda_1=1$（$w=1$）も $n\le2$ の 2 点で反証できる。 -/
theorem Bsat_ne_Xprime_at_two (Lam : ℕ) (h : ordKappaB 0 1 1 = ordKappaXprime 0 Lam 1) :
    ordKappaBsat 0 1 2 ≠ ordKappaXprime 0 Lam 2 := by
  have hLam : (Lam : ℤ) = 1 := by
    simp [ordKappaB, ordKappaXprime] at h
    omega
  simp [ordKappaBsat, ordKappaXprime, hLam]

end EllTwo
end IntegrableLattice
