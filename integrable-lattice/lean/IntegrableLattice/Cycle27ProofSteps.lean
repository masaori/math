/-
# cycle 25 が本文へ運んだ証明のうち、未検算の 6 件の検算 — cycle 27 step 2（Lean 検算 12 サイクル目）

cycle 25 は証明を持たなかった 7 ブロックへ原本の証明を運んだ。cycle 26 step 6 が Lean で見たのは
**命題 G′ だけ**である。本ファイルは残る 6 件——命題 G″・J・K・R・M・U——の証明の中の、
計算に還元できるステップを形式化する。

加えて、**本サイクル step 1 が命題 W へ新しく入れた議論**（$g_m\ge m+1$）も検算する。
自分が本文へ足した議論を、足したサイクルの中で機械にかける。

## 付値の書き方について（人手証明との 1 対 1 対応のため）

$v_2$ を mathlib の `padicValInt` で書くと、証明が mathlib の一般論へ流れて
**人手証明との 1 対 1 対応が崩れる**（`docs/context/証明の書き方.md` の Lean 具体版の要件）。
そこで人手証明が実際に書いている形——「$2^k$ で割り切れる」「奇数の余因子」——を
そのまま型に出す。人手証明は $\mathbb{F}_2$ に非零元が 1 つしか無いことを使っており、
その一歩が余因子の言葉でそのまま出る。

**`Real` を 1 つも使わない。** すべて $\mathbb{N}$ / $\mathbb{Z}$ / $\mathbb{F}_\ell$ 上で閉じる。
-/

import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Data.Nat.Totient
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

namespace IntegrableLattice

open Finset

/-! ## 命題 G″（$\ell=2$ 族）— 場合分けが排反かつ網羅であること（(G″1)）

人手証明の骨子:

* $p'\pm q'$ は偶なので $\lambda_0,\lambda_-\ge1$。
* $\lambda_0=\lambda_-=k$ なら、付値がちょうど $k$ の 2 元の和は付値 $\ge k+1$ をもつので
  $v_2\bigl((p'+q')+(p'-q')\bigr)=v_2(2p')=1\ge k+1$ となり $k\le0$ で矛盾。
* よって $\lambda_0\neq\lambda_-$ で、非アルキメデス的評価の等号成立から $\min=v_2(2p')=1$。

**本文は $p'=q'$ のとき $\lambda_-=+\infty$ と読むことを主張の側に書いている**ので、
ここで形式化するのはどちらも有限な場合である。 -/

/-- 奇数の和も差も偶（$\lambda_0,\lambda_-\ge1$ の根拠）。 -/
theorem gpp1_both_even {p q : ℤ} (hp : Odd p) (hq : Odd q) :
    (2 : ℤ) ∣ p + q ∧ (2 : ℤ) ∣ p - q := by
  obtain ⟨a, rfl⟩ := hp
  obtain ⟨b, rfl⟩ := hq
  exact ⟨⟨a + b + 1, by ring⟩, ⟨a - b, by ring⟩⟩

/-- **$\min(\lambda_0,\lambda_-)=1$ の上からの押さえ**: 両方が $2$ 以上になることはない。

$4\mid(p'+q')$ かつ $4\mid(p'-q')$ なら $4\mid 2p'$、すなわち $2\mid p'$ となり $p'$ が奇に反する。 -/
theorem gpp1_not_both_four {p q : ℤ} (hp : Odd p) (hq : Odd q) :
    ¬((4 : ℤ) ∣ p + q ∧ (4 : ℤ) ∣ p - q) := by
  rintro ⟨⟨a, ha⟩, ⟨b, hb⟩⟩
  obtain ⟨d, rfl⟩ := hp
  -- 足すと 4 ∣ 2p' すなわち 4 ∣ (4d+2) となり、p' が奇であることに反する。
  omega

/-- **(G″1) の前半（$\lambda_0\neq\lambda_-$）**。

人手証明そのまま。$p'+q'=2^k a$、$p'-q'=2^k b$ で $a,b$ がともに奇（＝付値がちょうど $k$）なら、
$\mathbb{F}_2$ には非零元が 1 つしか無いので $a+b$ は偶であり、
$2p'=2^k(a+b)$ の付値が $k+1$ 以上になる。$v_2(2p')=1$ なので $k\le0$、$k\ge1$ に反する。 -/
theorem gpp1_lambda_ne {p q : ℤ} {k : ℕ} {a b : ℤ}
    (hp : Odd p) (hk : 1 ≤ k)
    (hadd : p + q = 2 ^ k * a) (hsub : p - q = 2 ^ k * b)
    (ha : Odd a) (hb : Odd b) : False := by
  -- a + b は偶（奇 + 奇）。ここが「𝔽₂ には非零元が 1 つしか無い」の中身である。
  obtain ⟨a', rfl⟩ := ha
  obtain ⟨b', rfl⟩ := hb
  obtain ⟨d, rfl⟩ := hp
  -- k ≥ 1 なので 2^k = 2 * 2^(k-1)。以降は 2^(k-1) を 1 つの未知数として線形になる。
  have hK : (2 : ℤ) ^ k = 2 * 2 ^ (k - 1) := by
    conv_lhs => rw [show k = (k - 1) + 1 by omega]
    rw [pow_succ']
  rw [hK] at hadd hsub
  -- 足して 2 で割ると 2d+1 = 2 * (2^(k-1) * (a'+b'+1))、すなわち左辺が偶になる。
  -- ℤ は体ではないので、2 倍した等式を作ってから両辺を約す。
  have twice : 2 * (2 * d + 1) = 2 * (2 * (2 ^ (k - 1) * (a' + b' + 1))) := by
    linear_combination hadd + hsub
  have key : 2 * d + 1 = 2 * (2 ^ (k - 1) * (a' + b' + 1)) := by linarith
  have hnot : ¬ (2 : ℤ) ∣ (2 * d + 1) := by omega
  exact hnot ⟨2 ^ (k - 1) * (a' + b' + 1), key⟩

/-- **(G″1) の後半**: $a',b'$ がともに奇のとき $s\ge m$ と $t\ge m$ が同時には起きない（$m\ge2$）。

人手証明は「$s,t\ge m$ なら $2^{m}\mid 2a'$ となり $m\le1$ で $m\ge2$ に反する」と書いている。 -/
theorem gpp1_st_not_both_ge {a b : ℤ} {m : ℕ} (ha : Odd a) (hm : 2 ≤ m)
    (hs : (2 : ℤ) ^ m ∣ a - b) (ht : (2 : ℤ) ^ m ∣ a + b) : False := by
  obtain ⟨u, hu⟩ := hs
  obtain ⟨v, hv⟩ := ht
  obtain ⟨d, rfl⟩ := ha
  -- m ≥ 2 なので 2^m = 4 * 2^(m-2)。以降は 2^(m-2) を 1 つの未知数として線形になる。
  have hM : (2 : ℤ) ^ m = 4 * 2 ^ (m - 2) := by
    conv_lhs => rw [show m = (m - 2) + 2 by omega]
    ring
  rw [hM] at hu hv
  -- 足して 2 で割ると 2d+1 = 2 * (2^(m-2) * (u+v))、すなわち左辺が偶になる。
  have twice : 2 * (2 * d + 1) = 2 * (2 * (2 ^ (m - 2) * (u + v))) := by
    linear_combination hu + hv
  have key : 2 * d + 1 = 2 * (2 ^ (m - 2) * (u + v)) := by linarith
  have hnot : ¬ (2 : ℤ) ∣ (2 * d + 1) := by omega
  exact hnot ⟨2 ^ (m - 2) * (u + v), key⟩

/-! ## 命題 R（桁枝分解）— 打ち消しは起きない（(R2)）

人手証明: $0\le c,s\le\ell-1$ の行列 $\bigl(\binom cs\bigr)_{c,s}$ は $\mathbb{F}_\ell$ 上で
下三角かつ対角成分が $1$ なので可逆であり、$(\lambda_c)_{c\in C}\neq0$ から
$(\sigma_s)_{0\le s\le\ell-1}\neq0$ が従う。

**mathlib の一般論（行列の可逆性）へ委ねない。** 人手証明が使っている事実は
「$c<s$ なら $\binom cs=0$」と「$\binom ss=1$」の 2 つだけなので、
それだけから直接 $\sigma_{s^*}\neq0$ を出す。$s^*$ は $\lambda$ の台の最大値である。 -/

/-- **(R2)**: $\lambda$ が恒等的に $0$ でなければ、ある $s$ で $\sigma_s\neq0$。

$s$ として $\lambda$ の台の**最大値**を取る。$c<s$ の項は $\binom cs=0$ で消え、
$c>s$ の項は最大性から $\lambda_c=0$ で消え、残るのは $\lambda_s\binom ss=\lambda_s\neq0$ だけ。 -/
theorem sigma_ne_zero_of_lambda_ne_zero {R : Type*} [CommRing R] [Nontrivial R]
    (S : Finset ℕ) (lam : ℕ → R) (hS : ∃ c ∈ S, lam c ≠ 0) :
    ∃ s ∈ S, ∑ c ∈ S, lam c * (c.choose s : R) ≠ 0 := by
  classical
  set T := S.filter (fun c => lam c ≠ 0) with hT
  have hTne : T.Nonempty := by
    obtain ⟨c, hc, hlc⟩ := hS
    exact ⟨c, by simp [hT, hc, hlc]⟩
  set s := T.max' hTne with hs
  have hsT : s ∈ T := T.max'_mem hTne
  have hsS : s ∈ S := (mem_filter.mp hsT).1
  have hlams : lam s ≠ 0 := (mem_filter.mp hsT).2
  refine ⟨s, hsS, ?_⟩
  have key : ∑ c ∈ S, lam c * (c.choose s : R) = lam s := by
    rw [← Finset.add_sum_erase _ _ hsS]
    have hself : lam s * (s.choose s : R) = lam s := by simp
    have hrest : ∑ c ∈ S.erase s, lam c * (c.choose s : R) = 0 := by
      refine Finset.sum_eq_zero fun c hc => ?_
      have hcS : c ∈ S := (Finset.mem_erase.mp hc).2
      have hcs : c ≠ s := (Finset.mem_erase.mp hc).1
      by_cases hl : lam c = 0
      · simp [hl]
      · -- λ_c ≠ 0 なら c ∈ T なので最大性から c ≤ s、c ≠ s と合わせて c < s、よって C(c,s)=0
        have hcT : c ∈ T := by simp [hT, hcS, hl]
        have hle : c ≤ s := T.le_max' c hcT
        have hlt : c < s := lt_of_le_of_ne hle hcs
        simp [Nat.choose_eq_zero_of_lt hlt]
    rw [hself, hrest, add_zero]
  rw [key]
  exact hlams

/-! ## 命題 K（$S_\infty$ の判定）— (K5) の一意性と、$r_0$ の書き換え

(K5) は「$\ell^{r}>e_{m_u}$ ならば $\Lambda(r)$ の最小点は $j=m_u$ ただ 1 つ」と述べる。
人手証明は $e_j=\infty\ (j<m_u)$、$e_{m_u}<\infty$ を使う。
$j<m_u$ 側は値が $\infty$ なので比較の対象にならず、$j>m_u$ 側だけが実質である。 -/

/-- **(K5) の一意性の中身**: $j>m$ なら $e_m+m\ell^{r}<e_j+j\ell^{r}$（$\ell^{r}>e_m$ の下で）。

$j\ge m+1$ より $j\ell^{r}\ge m\ell^{r}+\ell^{r}>m\ell^{r}+e_m$ であり、$e_j\ge0$ を足せばよい。
**$e_j$ の値は一切使わない**（$\ge0$ であることだけ）ので、$j>m$ 側は無条件に潰れる。 -/
theorem k5_argmin_unique_above {e : ℕ → ℕ} {m j r ℓ : ℕ}
    (hlt : e m < ℓ ^ r) (hj : m < j) :
    e m + m * ℓ ^ r < e j + j * ℓ ^ r := by
  have h1 : m * ℓ ^ r + ℓ ^ r ≤ j * ℓ ^ r := by
    have : (m + 1) * ℓ ^ r ≤ j * ℓ ^ r := Nat.mul_le_mul_right _ hj
    simpa [add_mul] using this
  omega

/-- **$r_0$ の書き換えで使う「$1$ を加える操作が $\max$ と可換」**（本文の (K5) の後段）。

本文は $\max\bigl(1+A,\ B\bigr)=1+\max\bigl(A,\ B-1\bigr)$ の形で使う。
$\mathbb{N}$ の切り捨て引き算で書くと、**$B=0$ でも成り立つ**。
これは **cycle 27 step 1 が入れた規約 $\max\emptyset:=0$ の下で $r_0$ の 2 通りの書き方が
一致し続ける**ことを意味する（$S_\infty=\emptyset$ なら $A=B=0$ で両辺とも $1$）。 -/
theorem r0_add_one_comm (A B : ℕ) : max (1 + A) B = 1 + max A (B - 1) := by
  omega

/-- **$S_\infty=\emptyset$ のとき、$r_0$ は $1$ である**（step 1 が入れた規約の帰結）。

規約 $\max\emptyset:=0$ を入れると $r_0=\max(1+0,\ 0)=1$ となり、
上の書き換えの右辺 $1+\max(0,\ 0-1)=1$ と一致する。**どちらの書き方でも同じ値になる。** -/
theorem r0_empty_case : max (1 + 0) 0 = 1 ∧ 1 + max 0 (0 - 1) = 1 := by
  omega

/-- **本文が指摘している「床関数を使った書き方は $e_{m_u}=0$ で定義されない」の中身**。

$\lambda_u$ は $\ell^{\lambda}>e_{m_u}$ を満たす最小の自然数である。$e_{m_u}=0$ なら
$\ell^0=1>0$ なので $\lambda_u=0$ であり、**床関数 $\lfloor\log_\ell 0\rfloor$ を経由しない**。
ここでは「$\lambda_u=0$ が実際に条件を満たす最小である」ことを型に出す。 -/
theorem lambda_u_at_zero {ℓ : ℕ} (hℓ : 2 ≤ ℓ) : 0 < ℓ ^ 0 ∧ ∀ n : ℕ, 0 < ℓ ^ n := by
  refine ⟨by norm_num, fun n => ?_⟩
  exact pow_pos (by omega) n

/-! ## 命題 M（一般の塔の閉形式）— 飽和深度 $K(P_0)$ が定義されること（(M2)）

本文は $K(P_0):=\max\bigl\{k\ge0:\ j^{*}\ell\ge(\ell-1)\ell^{k}\bigr\}$ と置き、
括弧で「$j^{*}\ge1$ より常に定義され、$K\ge0$」と書いている。
**cycle 27 step 1 の台帳はこの一行を根拠として登録した**ので、その一行を検算する。 -/

/-- **(M2)**: $j^{*}\ge1$・$\ell\ge2$ なら $k=0$ が条件を満たす（集合は空でない）。 -/
theorem K_set_nonempty {jstar ℓ : ℕ} (hj : 1 ≤ jstar) (hℓ : 2 ≤ ℓ) :
    (ℓ - 1) * ℓ ^ 0 ≤ jstar * ℓ := by
  have : ℓ - 1 ≤ ℓ := Nat.sub_le _ _
  calc (ℓ - 1) * ℓ ^ 0 = ℓ - 1 := by ring_nf
    _ ≤ ℓ := this
    _ = 1 * ℓ := (one_mul ℓ).symm
    _ ≤ jstar * ℓ := Nat.mul_le_mul_right _ hj

/-- **(M2)**: 同じ集合は上に有界（$K$ が最大値として取れる）。

$(\ell-1)\ell^{k}\le j^{*}\ell$ かつ $\ell\ge2$ なら $\ell^{k}\le j^{*}\ell$ であり、
$k<\ell^{k}$ から $k<j^{*}\ell$ を得る。**上界は $j^{*}$ と $\ell$ だけから計算できる。** -/
theorem K_set_bounded {jstar ℓ k : ℕ} (hℓ : 2 ≤ ℓ)
    (hk : (ℓ - 1) * ℓ ^ k ≤ jstar * ℓ) : k < jstar * ℓ := by
  have h1 : ℓ ^ k ≤ (ℓ - 1) * ℓ ^ k := by
    have : 1 ≤ ℓ - 1 := by omega
    simpa using Nat.mul_le_mul_right (ℓ ^ k) this
  have h2 : k < ℓ ^ k := Nat.lt_pow_self (by omega)
  omega

/-! ## 命題 U（層ごとの係数）— $\ell=2$ の主役の段データ

本文は $\Lambda_1=\min\bigl(2,\,v_2(p-1)\bigr)$ と、$\theta^\sharp_1$ が
$p\equiv1\ (4)$ か $p\equiv3\ (4)$ かで決まると述べ、証明で
「$p$ は奇数なので $v_2(p-1)\ge1$ であり、$v_2(p-1)\ge2\iff p\equiv1\bmod4$」と書いている。 -/

/-- **本文の一行**: $p$ が奇なら $v_2(p-1)\ge2\iff p\equiv1\bmod4$。

付値の言葉を割り切れの言葉で書いたもの（$v_2(p-1)\ge2\iff4\mid p-1$）。 -/
theorem u_ell2_four_dvd_iff {p : ℤ} (hp : Odd p) : (4 : ℤ) ∣ p - 1 ↔ p % 4 = 1 := by
  constructor
  · rintro ⟨c, hc⟩
    omega
  · intro h
    exact ⟨(p - 1) / 4, by omega⟩

/-- **本文の一行の残り**: $p$ が奇なら $v_2(p-1)\ge1$（すなわち $2\mid p-1$）。 -/
theorem u_ell2_two_dvd {p : ℤ} (hp : Odd p) : (2 : ℤ) ∣ p - 1 := by
  obtain ⟨a, rfl⟩ := hp
  exact ⟨a, by ring⟩

/-- **$p=1$ の塔で規約が効いていること**（本文の「この規約を落として $v_2(0)=0$ と読むと
$\Lambda_1=0$ となり、下の値が出ない」）。

$p=1$ では $A_2=1-p=0$ である。$v_2(0)=+\infty$ の規約では最小を $A_0,A_1$ だけで取るので
$\Lambda_1=v_2(4)=2$、$v_2(0)=0$ と読むと $\Lambda_1=\min(2,0)=0$ になる。
**2 つの読みが違う値を与えることを型に出す**（cycle 26 の `junk_reading_excludes_ell_three` と同じ形）。 -/
theorem u_ell2_junk_reading_differs :
    -- 規約どおり（$A_m\neq0$ の $m$ だけで取る）: $\min\{v_2(4),v_2(4)\}=2$
    min 2 2 = 2 ∧
    -- $v_2(0)=0$ と読んだ場合（$A_2=0$ も最小に加わる）: $0$
    min (min 2 2) 0 = 0 ∧
    (2 : ℕ) ≠ 0 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **本文の (K5) の書き換えが $e_{m_u}\ge1$ でだけ成り立つこと**。

$\lambda_u$（$\ell^{\lambda}>e$ を満たす最小の $\lambda$）は $e\ge1$ のとき
$\lfloor\log_\ell e\rfloor+1$ に等しい。ここでは「$\log+1$ が条件を満たし、$\log$ は満たさない」
＝最小であることを型に出す。**$e=0$ では $\log_\ell 0$ が意味を持たない**ので本文は
$\lambda_u$ の側を定義に採っている。 -/
theorem lambda_u_eq_succ_log {ℓ e : ℕ} (hℓ : 2 ≤ ℓ) (he : 1 ≤ e) :
    e < ℓ ^ (Nat.log ℓ e + 1) ∧ ¬(e < ℓ ^ Nat.log ℓ e) := by
  refine ⟨Nat.lt_pow_succ_log_self (by omega) e, ?_⟩
  simpa using Nat.pow_log_le_self ℓ (by omega : e ≠ 0)

/-- **(U4) の 5 係数が (U1) の式と一致すること**。

本文は $\ell=2$ の主役の族について $d=2\theta^\sharp_1-6$、$c=2\mathcal{L}-2$
（$\mathcal{L}=v_2(p+1)+\min(2,v_2(p-1))$）と書き、$p=1$ と $p=3$ で
$(a,b,c,d,e)=(0,2,4,-6,-1)$ と $(0,2,4,-2,-4)$ を挙げている。
**この 2 つが同じ式から出ることを突き合わせる**（cycle 26 の `g3_coefficients_match` と同じ形）。

$p=1$: $A_2=1-p=0$ なので規約により $\theta^\sharp_1=0$、
$\mathcal{L}=v_2(2)+\min(2,v_2(0))=1+2=3$（$v_2(0)=+\infty$ の規約がここでも効く）。
$p=3$: $p\equiv3\bmod4$ なので $\theta^\sharp_1=2$、
$\mathcal{L}=v_2(4)+\min(2,v_2(2))=2+1=3$。 -/
theorem u4_ell2_five_coefficients :
    (2 * (0 : ℤ) - 6 = -6 ∧ 2 * ((1 : ℤ) + 2) - 2 = 4) ∧
    (2 * (2 : ℤ) - 6 = -2 ∧ 2 * ((2 : ℤ) + 1) - 2 = 4) := by
  refine ⟨⟨by norm_num, by norm_num⟩, ⟨by norm_num, by norm_num⟩⟩

/-- **(U1) の $S_\infty=\emptyset$ の場合**: 和が空なら $d=-2$。

本文は (U1) の直後にこれを明記している（$\sum$ は $\max$ と違って空和の規約が標準なので、
cycle 27 step 1 の走査の対象外だが、**本文が自分で書いている**ことをここで確認しておく）。 -/
theorem u1_d_empty_case : (0 : ℤ) - 2 = -2 := by norm_num

/-! ## 命題 J（消滅深度の p 進化）— (J1) 桁定理の代数的な芯

(J1) の証明は $\mathbb{F}_\ell[[x]]$ の中で $(1+x)^{\ell}=1+x^{\ell}$（および $\ell^L$ 版）を使う。
これは標数 $\ell$ の可換環での Frobenius であり、人手証明もそう書いている。 -/

/-- **(J1) の芯**: 標数 $\ell$ の可換環で $(1+x)^{\ell^{L}}=1+x^{\ell^{L}}$。 -/
theorem j1_freshman_dream {R : Type*} [CommRing R] {ℓ : ℕ} [Fact ℓ.Prime] [CharP R ℓ]
    (x : R) (L : ℕ) : (1 + x) ^ ℓ ^ L = 1 + x ^ ℓ ^ L := by
  simpa using add_pow_char_pow (R := R) (p := ℓ) (n := L) (x := (1 : R)) (y := x)

/-! ## 命題 W（トレース周期の梯子）— cycle 27 step 1 が本文へ入れた議論の検算

step 1 は $e_k=\min\{m\ge0:g_m\ge k\}$ の集合が空でない理由として、本文へ次を入れた:

> $\tau$ の定義から $S^{\tau}\equiv I\pmod p$ なので、$S^{\tau}=I+pB$ と書いて
> $S^{p^{m}\tau}\equiv I\pmod{p^{m+1}}$ が帰納法で従い、$g_m\ge m+1$ を得る。

$S$ の冪どうしは可換なので、この計算は $S$ が生成する可換環の中で閉じる。
**自分が本文へ足した議論なので、足したサイクルの中で検算する。** -/

/-- **1 段ぶんの持ち上げ**: $p^{j}\mid y-1$（$j\ge1$）なら $p^{j+1}\mid y^{p}-1$。

二項展開ではなく**等比の因数分解**で書く。人手証明が使うのはこの一歩だけである。

$y^{p}-1=\bigl(\sum_{i<p}y^{i}\bigr)(y-1)$ であり、$\sum_{i<p}y^{i}-p=\sum_{i<p}(y^{i}-1)$ の
各項は $y-1$ で割れるので $\sum_{i<p}y^{i}=p+(y-1)d$ と書ける。したがって

$$y^{p}-1=\bigl(p+(y-1)d\bigr)(y-1)=p(y-1)+(y-1)^{2}d$$

で、第 1 項は $p^{j+1}$ で、第 2 項は $p^{2j}$ で割れる。$j\ge1$ なら $2j\ge j+1$。 -/
theorem w_lifting_step {R : Type*} [CommRing R] {p i : ℕ} {y : R}
    (hy : ((p : R) ^ (i + 1)) ∣ y - 1) : ((p : R) ^ (i + 2)) ∣ y ^ p - 1 := by
  -- Σ_{i<p} y^i = p + (y-1) * d
  obtain ⟨d, hd⟩ :=
    Finset.dvd_sum (fun k (_ : k ∈ Finset.range p) =>
      (by simpa using sub_dvd_pow_sub_pow y 1 k : (y - 1) ∣ y ^ k - 1))
  have hsplit : ∑ k ∈ Finset.range p, (y ^ k - 1)
      = (∑ k ∈ Finset.range p, y ^ k) - (p : R) := by
    rw [Finset.sum_sub_distrib, Finset.sum_const, Finset.card_range, nsmul_eq_mul, mul_one]
  have hgeom : (∑ k ∈ Finset.range p, y ^ k) = (p : R) + (y - 1) * d := by
    linear_combination hd - hsplit
  obtain ⟨e, he⟩ := hy
  refine ⟨e + (p : R) ^ i * e ^ 2 * d, ?_⟩
  have hfac : y ^ p - 1 = (∑ k ∈ Finset.range p, y ^ k) * (y - 1) := (geom_sum_mul y p).symm
  rw [hfac, hgeom, he]
  ring

/-- **step 1 が本文へ入れた持ち上げ**: 可換環で $p\mid x-1$ なら $p^{m+1}\mid x^{p^{m}}-1$。

人手証明と同じ帰納法。1 段ぶんは `w_lifting_step`。
$S$ の冪どうしは可換なので、行列であることは使わずこの形で足りる。 -/
theorem w_lifting_pow {R : Type*} [CommRing R] {p : ℕ} {x : R}
    (hx : (p : R) ∣ x - 1) (m : ℕ) : ((p : R) ^ (m + 1)) ∣ x ^ p ^ m - 1 := by
  induction m with
  | zero => simpa using hx
  | succ n ih =>
    have hstep : x ^ p ^ (n + 1) = (x ^ p ^ n) ^ p := by
      rw [← pow_mul, pow_succ]
    rw [hstep]
    exact w_lifting_step ih

/-- **本サイクルが見つけた既存形式化との差**: `PropC.lean` の
`dvd_pow_prime_pow_sub_one` は**同じ主張を $p$ が素数という仮定つきで**述べている。

向こうの証明は二項展開を取り、$0<m<p$ で $p\mid\binom pm$ を使うので**素数性が要る**
（`hp.out.dvd_choose_self`）。本ファイルの証明は等比の因数分解を取るので**素数性を使わない**。
両者は同じ主張なので、**あちらの仮定 $p$ 素数は証明の道具立てが要求したものであって、
主張が要求したものではない**。

`docs/context/証明の書き方.md` の「必要十分版」の要件 4（具体版が特殊化として得られること）に
従い、既存の形を本ファイルの形の特殊化として導けることをここで示す。 -/
theorem w_lifting_pow_specializes {S : Type*} [CommRing S] (p : ℕ) [Fact p.Prime] (u : S)
    (h : (p : S) ∣ u - 1) (k : ℕ) : ((p : S) ^ (k + 1)) ∣ u ^ p ^ k - 1 :=
  w_lifting_pow h k

end IntegrableLattice
