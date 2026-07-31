/-
# 命題 C（Pisano 型上界）の残り — 周期そのものの整除

対応する人手証明:
`integrable-lattice/outputs/paper-plans/002_R_Lambda_duality.md` §2 **命題 C**
（$\pi(p,k)\mid p^{k-1}\pi(p,1)$）。設定は同 §2 命題 A
（根拠 report: `outputs/reports/cycle3_T1_D-U2_rigorous.md`）と同じ。

`PropC.lean` は「還元 $GL_d(\mathbb{Z}/p^k)\to GL_d(\mathbb{Z}/p)$ の核の指数が $p^{k-1}$ を割る」
という**代数的核**だけを形式化していた（`matrix_pow_prime_pow_eq_one`）。
本ファイルはその残り、すなわち

* 核の仮定「$U\equiv I \pmod p$」を、還元写像 $\mathbb{Z}/p^k\to\mathbb{Z}/p$ から**実際に取り出す**段、
* 周期 $\pi(p,k)$ を `orderOf` として定義して整除 $\pi(p,k)\mid \pi(p,1)\,p^{k-1}$ を結論する段、
* 人手証明が「$p\nmid\det T$ なら列は純周期的だから最終周期＝`orderOf`」と述べている段

を形式化する。これで命題 C は（整除方向について）閉じる。

## 形式化した主張

* `eq_natCast_mul_of_castHom_eq_zero` — $x\in\mathbb{Z}/p^k$ が mod $p$ で $0$ なら $x=p\cdot y$。
  商 $y$ は `x.val / p` として**明示的に構成**しており、選択公理を使っていない。
* `matrix_eq_natCast_mul_of_map_castHom_eq_zero` — その行列版。
* `matrix_pow_mul_prime_pow_eq_one` — $\bar A^m=I$（mod $p$）$\Rightarrow A^{m p^{k-1}}=I$（mod $p^k$）。
* `orderOf_dvd_mul_prime_pow` — $\operatorname{ord}(A)\mid \operatorname{ord}(\bar A)\,p^{k-1}$。
* `orderOf_reduction_dvd` — 整数行列 $T$ に対する形。これが $\pi(p,k)\mid \pi(p,1)p^{k-1}$ である。
* `isUnit_pow_add_eq_iff` — $A$ 可逆なら $A^{N+t}=A^N\iff A^t=1$。
  人手証明の「純周期的だから最終周期＝乗法的位数」を正当化する。
* `isUnit_map_of_not_dvd_det` — $p\nmid\det T$ なら $T\bmod p^k$ は可逆。

## 形式化していない主張

* **等号（Wall 型 $\pi(p,k)=p^{k-1}\pi(p,1)$）は形式化していない。**
  人手証明のとおり一般には**偽**である（cycle 6 で六頂点 572 件中 4.5\% の反例）。
  ここで扱うのは整除（上界）方向だけである。
* 「最終周期の最小値」という概念自体を `Nat.find` 等で定義してはいない。
  代わりに `isUnit_pow_add_eq_iff` により、可逆の場合に最終周期の条件が
  $A^t=1$ と同値であることを示し、`orderOf`（＝そのような最小の $t$）で議論している。

**新規性は主張しない**（Pisano 型上界は古典）。
-/
import Mathlib
import IntegrableLattice.PropC

namespace IntegrableLattice

open Matrix

variable {p k : ℕ} [hp : Fact p.Prime]

/-- $\mathbb{Z}/p^k$ の元 $x$ が mod $p$ で $0$ なら $x = p\cdot(\lfloor x.val/p\rfloor)$。
商を明示的に構成しているので選択公理を使わない。 -/
theorem eq_natCast_mul_of_castHom_eq_zero (hk : k ≠ 0) (x : ZMod (p ^ k))
    (hx : ZMod.castHom (dvd_pow_self p hk) (ZMod p) x = 0) :
    x = (p : ZMod (p ^ k)) * ((x.val / p : ℕ) : ZMod (p ^ k)) := by
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k hp.out.pos.ne'⟩
  have hval : ((x.val : ℕ) : ZMod p) = 0 := by
    rw [ZMod.natCast_val, ← ZMod.castHom_apply (h := dvd_pow_self p hk)]
    exact hx
  obtain ⟨c, hc⟩ := (CharP.cast_eq_zero_iff (ZMod p) p x.val).mp hval
  have hdiv : x.val / p = c := by
    rw [hc, Nat.mul_div_cancel_left c hp.out.pos]
  have hx' : ((x.val : ℕ) : ZMod (p ^ k)) = x := by
    rw [ZMod.natCast_val, ZMod.cast_id]
  rw [hdiv]
  calc x = ((x.val : ℕ) : ZMod (p ^ k)) := hx'.symm
    _ = ((p * c : ℕ) : ZMod (p ^ k)) := by rw [hc]
    _ = (p : ZMod (p ^ k)) * (c : ZMod (p ^ k)) := by push_cast; ring

/-- 行列版: mod $p$ で $0$ になる行列は $p$ 倍で書ける。 -/
theorem matrix_eq_natCast_mul_of_map_castHom_eq_zero {d : ℕ} (hk : k ≠ 0)
    (M : Matrix (Fin d) (Fin d) (ZMod (p ^ k)))
    (hM : M.map (ZMod.castHom (dvd_pow_self p hk) (ZMod p)) = 0) :
    ∃ V, M = (p : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) * V := by
  refine ⟨M.map (fun x => ((x.val / p : ℕ) : ZMod (p ^ k))), ?_⟩
  ext i j
  have hij : ZMod.castHom (dvd_pow_self p hk) (ZMod p) (M i j) = 0 := by
    have := congrFun (congrFun hM i) j
    simpa [Matrix.map_apply] using this
  have h1 := eq_natCast_mul_of_castHom_eq_zero hk (M i j) hij
  rw [← nsmul_eq_mul]
  simpa [Matrix.map_apply, nsmul_eq_mul] using h1

/-- 還元写像は行列の冪と可換（`RingHom.mapMatrix` の `map_pow`）。 -/
theorem map_pow_castHom {d : ℕ} (hk : k ≠ 0)
    (B : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) (j : ℕ) :
    (B ^ j).map (ZMod.castHom (dvd_pow_self p hk) (ZMod p))
      = (B.map (ZMod.castHom (dvd_pow_self p hk) (ZMod p))) ^ j := by
  simpa [RingHom.mapMatrix_apply] using
    map_pow ((ZMod.castHom (dvd_pow_self p hk) (ZMod p)).mapMatrix :
      Matrix (Fin d) (Fin d) (ZMod (p ^ k)) →+* Matrix (Fin d) (Fin d) (ZMod p)) B j

/-- 還元写像は行列の差と可換。 -/
theorem map_sub_castHom {d : ℕ} (hk : k ≠ 0)
    (B C : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) :
    (B - C).map (ZMod.castHom (dvd_pow_self p hk) (ZMod p))
      = B.map (ZMod.castHom (dvd_pow_self p hk) (ZMod p))
        - C.map (ZMod.castHom (dvd_pow_self p hk) (ZMod p)) := by
  simpa [RingHom.mapMatrix_apply] using
    map_sub ((ZMod.castHom (dvd_pow_self p hk) (ZMod p)).mapMatrix :
      Matrix (Fin d) (Fin d) (ZMod (p ^ k)) →+* Matrix (Fin d) (Fin d) (ZMod p)) B C

/-- 還元写像は単位行列を単位行列へ送る。 -/
theorem map_one_castHom {d : ℕ} (hk : k ≠ 0) :
    (1 : Matrix (Fin d) (Fin d) (ZMod (p ^ k))).map
        (ZMod.castHom (dvd_pow_self p hk) (ZMod p)) = 1 := by
  simpa [RingHom.mapMatrix_apply] using
    map_one ((ZMod.castHom (dvd_pow_self p hk) (ZMod p)).mapMatrix :
      Matrix (Fin d) (Fin d) (ZMod (p ^ k)) →+* Matrix (Fin d) (Fin d) (ZMod p))

/-- **命題 C の本体**: mod $p$ での $m$ 乗が単位行列なら、mod $p^k$ では $m\,p^{k-1}$ 乗が単位行列。 -/
theorem matrix_pow_mul_prime_pow_eq_one {d : ℕ} (hk : k ≠ 0)
    (A : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) (m : ℕ)
    (hm : (A.map (ZMod.castHom (dvd_pow_self p hk) (ZMod p))) ^ m = 1) :
    A ^ (m * p ^ (k - 1)) = 1 := by
  have hzero : (A ^ m - 1).map (ZMod.castHom (dvd_pow_self p hk) (ZMod p)) = 0 := by
    rw [map_sub_castHom hk, map_pow_castHom hk, hm, map_one_castHom hk, sub_self]
  obtain ⟨V, hV⟩ := matrix_eq_natCast_mul_of_map_castHom_eq_zero hk (A ^ m - 1) hzero
  have hU : A ^ m = 1 + (p : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) * V := by
    rw [← hV]; abel
  have hpow := matrix_pow_prime_pow_eq_one (p := p) (k := k) (d := d) hk (A ^ m) ⟨V, hU⟩
  rwa [← pow_mul] at hpow

/-- $\operatorname{ord}(A) \mid \operatorname{ord}(\bar A)\, p^{k-1}$。
`pow_orderOf_eq_one` はモノイドで無条件に成り立つ（有限位数でないときは `orderOf = 0`）ので、
可逆性の仮定は不要である。 -/
theorem orderOf_dvd_mul_prime_pow {d : ℕ} (hk : k ≠ 0)
    (A : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) :
    orderOf A ∣ orderOf (A.map (ZMod.castHom (dvd_pow_self p hk) (ZMod p))) * p ^ (k - 1) :=
  orderOf_dvd_of_pow_eq_one
    (matrix_pow_mul_prime_pow_eq_one hk A _ (pow_orderOf_eq_one _))

/-- **$\pi(p,k)\mid \pi(p,1)\,p^{k-1}$**（整数行列 $T$ の形）。
$\pi(p,k)$ は $T\bmod p^k$ の乗法的位数である（純周期性は `isUnit_pow_add_eq_iff` を見よ）。 -/
theorem orderOf_reduction_dvd {d : ℕ} (hk : k ≠ 0) (T : Matrix (Fin d) (Fin d) ℤ) :
    orderOf (T.map (fun a : ℤ => (a : ZMod (p ^ k)))) ∣
      orderOf (T.map (fun a : ℤ => (a : ZMod p))) * p ^ (k - 1) := by
  have hmap :
      (T.map (fun a : ℤ => (a : ZMod (p ^ k)))).map
          (ZMod.castHom (dvd_pow_self p hk) (ZMod p))
        = T.map (fun a : ℤ => (a : ZMod p)) := by
    ext i j
    simp [Matrix.map_apply]
  rw [← hmap]
  exact orderOf_dvd_mul_prime_pow hk _

/-- 人手証明の「$p\nmid\det T$ なら列 $T^N$ は純周期的なので最終周期＝乗法的位数」の中身。
可逆な $A$ について、$A^{N+t}=A^N$ は $N$ に依らず $A^t=1$ と同値である。 -/
theorem isUnit_pow_add_eq_iff {M : Type*} [Monoid M] {A : M} (hA : IsUnit A) (N t : ℕ) :
    A ^ (N + t) = A ^ N ↔ A ^ t = 1 := by
  constructor
  · intro h
    refine (hA.pow N).mul_left_cancel ?_
    rw [mul_one, ← pow_add]
    exact h
  · intro h
    rw [pow_add, h, mul_one]

/-- $p\nmid x$（整数）なら $x$ の $\mathbb{Z}/p^k$ での像は可逆。 -/
theorem isUnit_intCast_of_not_dvd (hk : k ≠ 0) {x : ℤ} (hx : ¬ (p : ℤ) ∣ x) :
    IsUnit ((x : ZMod (p ^ k))) := by
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k hp.out.pos.ne'⟩
  have hnat : ¬ p ∣ x.natAbs := by
    intro h
    exact hx (Int.dvd_natAbs.mp (Int.natCast_dvd_natCast.mpr h))
  have hcop : Nat.Coprime x.natAbs (p ^ k) :=
    Nat.Coprime.pow_right k ((Nat.Prime.coprime_iff_not_dvd hp.out).mpr hnat).symm
  have hu : IsUnit ((x.natAbs : ℕ) : ZMod (p ^ k)) := (ZMod.isUnit_iff_coprime _ _).mpr hcop
  rcases Int.natAbs_eq x with h | h
  · rw [h]; simpa using hu
  · rw [h]; simpa using hu.neg

/-- $p\nmid\det T$ なら $T\bmod p^k$ は可逆。`isUnit_pow_add_eq_iff` と合わせて
「最終周期＝`orderOf`」が言える。 -/
theorem isUnit_map_of_not_dvd_det {d : ℕ} (hk : k ≠ 0) (T : Matrix (Fin d) (Fin d) ℤ)
    (hdet : ¬ (p : ℤ) ∣ T.det) :
    IsUnit (T.map (fun a : ℤ => (a : ZMod (p ^ k)))) := by
  rw [Matrix.isUnit_iff_isUnit_det]
  have hd : (T.map (fun a : ℤ => (a : ZMod (p ^ k)))).det = ((T.det : ℤ) : ZMod (p ^ k)) :=
    (RingHom.map_det (Int.castRingHom (ZMod (p ^ k))) T).symm
  rw [hd]
  exact isUnit_intCast_of_not_dvd hk hdet

end IntegrableLattice
