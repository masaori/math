/-
# $w^*$ をトレース列の周期の主張へ結ぶ段 — cycle 37 step 3

対応する人手証明:

* 本文ブロック `paper_043b_theorem_trace_bound`（命題 C′）の証明の
  「$Gb\equiv0\ (p^k)$ から $b\equiv0\ (p^{k-w^*})$」
* 本文ブロック `paper_045_theorem_trace_ladder`（命題 C″）が同じ段に依っている箇所

## なぜこのファイルが要るのか

`TracePeriodAssembly.lean` は、命題 C′ の上界そのものは組み立てているが、
その途中で使う「$p^{w^*}G^{-1}$ が $p$ 進整数成分をもつ」を**仮定 `hlift` として型に出しただけ**である。
一方 `WStarElementaryDivisors.lean` は $w^*$ を適合基底の係数の $p$ 進付値の最大値として定義し、
それが $\{j:\ p^jM\subseteq N\ (p\ \text{の外で})\}$ の最小元であることを証明している。

**2 つは繋がっていなかった。** 台帳は 命題 C′ と 命題 C″ の両方について
「残っているのは、その $w^*$ をトレース列の周期の主張へ結ぶ段である」と書いていた。
本ファイルがその段を書く。

なお 命題 C″ には、この壁とは別に 2 つの残りがある（しきい値 $w^*+1$ の最良性と、
$e_k=\min\{m:g_m\ge k\}$ の同値）。本ファイルはそちらには触れていない。

## 何を書いたか（$\mathbb{R}$ も体も使わない）

`IsPLevel` は「どの $x$ についても $p^{w}x$ が $p$ の外で $N$ に属する」という形をしている。
$N$ を $G$ の像に取り、$x$ を単位ベクトルへ当てると、各 $i$ について
$G y_i = m_i p^{w} e_i$ となる整数ベクトル $y_i$（$m_i$ は $p$ と素）が得られる。
$m=\prod_i m_i$ と置いて係数を揃えると、**行列の等式 $G\,Y=(m\,p^{w})I$** になる
（`exists_mul_eq_smul_one_of_isPLevel`）。

これは $Y$ が右からの逆であって、`dvd_of_mulVec_dvd` が要求する左からの形ではない。
$\det G\neq0$ なら左右は入れ替えられる（`mul_comm_of_det_ne_zero`）。

最後に、`PropCTracePeriod.dvd_of_mulVec_dvd` を $p$ と素な係数 $m$ を許す形へ一般化し
（`dvd_of_mulVec_dvd_unit`）、上と繋いで
**$Gb\equiv0\ (p^k)$ ならば $b\equiv0\ (p^{k-w})$** を出す（`dvd_of_mulVec_dvd_of_isPLevel`）。

## 形式化しなかったもの

* **$G$ の像の適合基底の係数が、本文の言う「$G$ の最大単因子」であること。**
  本ファイルが使うのは `IsPLevel`（$p$ の外での包含の最小レベル）だけで、
  整除の鎖を経由していない。本文が $w^*=v_p(e_r)$ と書いているのは鎖の言葉なので、
  **鎖の言葉との一致は書いていない**（`WStarElementaryDivisors` が
  「最大単因子を経由していない」と書いているのと同じ限界である）。
* 成分への射影で $\mu$ の像が $a_i$ であることの同定
  （$\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$ の残り）。
  これは 命題 C′ に残るもう 1 つである。
  **ノルムを重複度の積へ分ける側は cycle 43 step 2 で入り**
  （`PropCCrtWiring.norm_eq_prod_pow_natDegree`）、
  **射影の側は cycle 44 step 1 で入った**（`PropCMuComponent.algHomOfDvd_mu_eq_multiplicity`）。
  **いまは残りではない。そう書く。**
-/
import Mathlib
import IntegrableLattice.PropCTracePeriod
import IntegrableLattice.WStarElementaryDivisors

namespace IntegrableLattice
namespace TracePeriodWStar

open Finset Matrix

/-! ## 1. 行列式が $0$ でなければ左から消せる -/

/-- 行列式が $0$ でなければ、掛け算は単射である。 -/
theorem mulVec_injective_of_det_ne_zero {r : ℕ} (G : Matrix (Fin r) (Fin r) ℤ)
    (hdet : G.det ≠ 0) : Function.Injective G.mulVec := by
  intro x y hxy
  by_contra hne
  refine hdet (Matrix.exists_mulVec_eq_zero_iff.mp ⟨x - y, sub_ne_zero.mpr hne, ?_⟩)
  rw [Matrix.mulVec_sub, hxy, sub_self]

/-- 行列式が $0$ でなければ、左から掛けた等式は消せる。 -/
theorem mul_left_cancel_of_det_ne_zero {r : ℕ} (G A B : Matrix (Fin r) (Fin r) ℤ)
    (hdet : G.det ≠ 0) (h : G * A = G * B) : A = B := by
  have hinj := mulVec_injective_of_det_ne_zero G hdet
  ext a i
  have hcol : G.mulVec (fun b => A b i) = G.mulVec (fun b => B b i) := by
    funext x
    have hx := congrFun (congrFun h x) i
    simpa [Matrix.mul_apply, Matrix.mulVec, dotProduct] using hx
  exact congrFun (hinj hcol) a

/-- 右からの逆は左からの逆でもある（行列式が $0$ でないとき）。 -/
theorem mul_comm_of_det_ne_zero {r : ℕ} (G Y : Matrix (Fin r) (Fin r) ℤ) (c : ℤ)
    (hdet : G.det ≠ 0) (h : G * Y = c • (1 : Matrix (Fin r) (Fin r) ℤ)) :
    Y * G = c • (1 : Matrix (Fin r) (Fin r) ℤ) := by
  refine mul_left_cancel_of_det_ne_zero G _ _ hdet ?_
  rw [← Matrix.mul_assoc, h, Matrix.smul_mul, Matrix.one_mul, Matrix.mul_smul,
    Matrix.mul_one]

/-! ## 2. `IsPLevel` から行列の等式を作る -/

/-- **本ファイルの心臓部**。$G$ の像について $p$ の外でのレベルが $w$ 以下なら、
$p$ と素な整数 $m$ と整数行列 $Y$ があって $G\,Y=(m\,p^{w})I$ となる。

`IsPLevel` を単位ベクトルへ当てて得た $G y_i=m_i p^{w}e_i$ を、
$m=\prod_i m_i$ で係数を揃えて並べただけである。 -/
theorem exists_mul_eq_smul_one_of_isPLevel {r : ℕ} {p w : ℕ} (hp : p.Prime)
    (G : Matrix (Fin r) (Fin r) ℤ)
    (hlevel : IsPLevel p (LinearMap.range G.mulVecLin) w) :
    ∃ (Y : Matrix (Fin r) (Fin r) ℤ) (m : ℤ), ¬ (p : ℤ) ∣ m ∧
      G * Y = (m * (p : ℤ) ^ w) • (1 : Matrix (Fin r) (Fin r) ℤ) := by
  classical
  -- 各単位ベクトルへ当てる。
  have hcol : ∀ i : Fin r, ∃ (y : Fin r → ℤ) (mi : ℤ), ¬ (p : ℤ) ∣ mi ∧
      G.mulVec y = (mi * (p : ℤ) ^ w) • (Pi.single i (1 : ℤ)) := by
    intro i
    obtain ⟨mi, hmi, hmem⟩ := hlevel (Pi.single i (1 : ℤ))
    obtain ⟨y, hy⟩ := hmem
    refine ⟨y, mi, hmi, ?_⟩
    rw [← Matrix.mulVecLin_apply, hy, smul_smul]
  choose y mm hmm hy using hcol
  refine ⟨Matrix.of fun a i => (∏ j ∈ univ.erase i, mm j) * y i a, ∏ j, mm j, ?_, ?_⟩
  · -- 素数は積を割らない（各因子を割らないので）。
    intro hdvd
    obtain ⟨j, -, hj⟩ := (Prime.dvd_finsetProd_iff (Nat.prime_iff_prime_int.mp hp) _).mp hdvd
    exact hmm j hj
  · ext a i
    have hprod : (∏ j ∈ univ.erase i, mm j) * mm i = ∏ j, mm j := by
      rw [mul_comm, Finset.mul_prod_erase _ _ (Finset.mem_univ i)]
    have hmul : (G * Matrix.of fun a i => (∏ j ∈ univ.erase i, mm j) * y i a) a i
        = (∏ j ∈ univ.erase i, mm j) * G.mulVec (y i) a := by
      simp only [Matrix.mul_apply, Matrix.of_apply, Matrix.mulVec, dotProduct,
        Finset.mul_sum]
      exact Finset.sum_congr rfl fun b _ => by ring
    rw [hmul, hy i]
    simp only [Pi.smul_apply, smul_eq_mul, Matrix.smul_apply, Matrix.one_apply]
    rw [← mul_assoc, ← mul_assoc, hprod]
    by_cases hai : a = i <;> simp [hai]

/-! ## 3. $p$ と素な係数を許した割り切れの段 -/

/-- `PropCTracePeriod.dvd_of_mulVec_dvd` を、$p$ と素な係数 $m$ を許す形へ一般化したもの。
$m$ は $p$ と素なので、$p$ 冪の割り切れには効かない。 -/
theorem dvd_of_mulVec_dvd_unit {r : ℕ} {p w k : ℕ} (hp : p.Prime)
    (M H : Matrix (Fin r) (Fin r) ℤ) (b : Fin r → ℤ) (m : ℤ) (hm : ¬ (p : ℤ) ∣ m)
    (hHM : H * M = (m * (p : ℤ) ^ w) • (1 : Matrix (Fin r) (Fin r) ℤ))
    (hb : ∀ i, (p : ℤ) ^ k ∣ (M.mulVec b) i) (i : Fin r) :
    (p : ℤ) ^ (k - w) ∣ b i := by
  classical
  choose c hc using hb
  have hMb : M.mulVec b = ((p : ℤ) ^ k) • c := funext fun j => by rw [hc j]; simp
  have key : (p : ℤ) ^ k ∣ (m * (p : ℤ) ^ w) * b i := by
    have h1 : ((m * (p : ℤ) ^ w)) • b = H.mulVec (M.mulVec b) := by
      rw [Matrix.mulVec_mulVec, hHM, Matrix.smul_mulVec, Matrix.one_mulVec]
    have h2 : H.mulVec (M.mulVec b) = ((p : ℤ) ^ k) • H.mulVec c := by
      rw [hMb, Matrix.mulVec_smul]
    have h3 := congrFun (h1.trans h2) i
    simp only [Pi.smul_apply, smul_eq_mul] at h3
    exact ⟨H.mulVec c i, h3⟩
  -- `m` は `p` と素なので落とせる。
  have hcop : IsCoprime ((p : ℤ) ^ (k - w)) m := by
    refine IsCoprime.pow_left ?_
    exact ((Nat.prime_iff_prime_int.mp hp).coprime_iff_not_dvd).mpr hm
  by_cases hwk : w ≤ k
  · have hsplit : (p : ℤ) ^ k = (p : ℤ) ^ w * (p : ℤ) ^ (k - w) := by
      rw [← pow_add]; congr 1; omega
    rw [hsplit] at key
    have hne : ((p : ℤ) ^ w) ≠ 0 := pow_ne_zero _ (by exact_mod_cast hp.pos.ne')
    have key' : (p : ℤ) ^ (k - w) ∣ m * b i := by
      have hrew : (m * (p : ℤ) ^ w) * b i = (p : ℤ) ^ w * (m * b i) := by ring
      rw [hrew] at key
      exact (mul_dvd_mul_iff_left hne).mp key
    exact hcop.dvd_of_dvd_mul_left key'
  · have : k - w = 0 := by omega
    rw [this, pow_zero]
    exact one_dvd _

/-! ## 4. 繋いだ形（命題 C′ と 命題 C″ が共有していた壁） -/

/-- **本文の「$Gb\equiv0\ (p^k)$ から $b\equiv0\ (p^{k-w^*})$」**。

仮定は 2 つだけである——$\det G\neq0$ と、$G$ の像の $p$ の外でのレベルが $w$ 以下であること。
後者は `WStarElementaryDivisors.isLeast_isPLevel` が適合基底の係数の $p$ 進付値の最大値として
与えているものであり、本文の $w^*$ にあたる。

`TracePeriodAssembly.lean` が仮定 `hlift` として型に出していた段は、これで埋まる。 -/
theorem dvd_of_mulVec_dvd_of_isPLevel {r : ℕ} {p w k : ℕ} (hp : p.Prime)
    (G : Matrix (Fin r) (Fin r) ℤ) (hdet : G.det ≠ 0)
    (hlevel : IsPLevel p (LinearMap.range G.mulVecLin) w)
    (b : Fin r → ℤ) (hb : ∀ i, (p : ℤ) ^ k ∣ (G.mulVec b) i) (i : Fin r) :
    (p : ℤ) ^ (k - w) ∣ b i := by
  obtain ⟨Y, m, hm, hGY⟩ := exists_mul_eq_smul_one_of_isPLevel hp G hlevel
  exact dvd_of_mulVec_dvd_unit hp G Y b m hm
    (mul_comm_of_det_ne_zero G Y _ hdet hGY) hb i

end TracePeriodWStar
end IntegrableLattice
