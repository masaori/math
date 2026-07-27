/-
# Rayleigh 商による作用素の評価とモーメント列の対数凸性（抽象版）

対応する人手証明のラベル:
* **`rayleigh_bounds_operator_norm`**（`maxeig_007_claim_operator_bound`）
* **`trace_power_sandwich`** の Step 2・Step 3（`maxeig_008_claim_trace_power_sandwich`）

具体版:
* `Ising2D.rayleigh_bounds_operator_norm`（`Ising2D/Part011/Claim007_OperatorBound.lean`）
* `Ising2D.trace_power_sandwich`（`Ising2D/Part011/Claim008_TracePowerSandwich.lean`）

いずれも本ファイルの結果の特殊化として導出している。

## この主張に本質的に効いている構造

人手証明は `W ∈ Mat(2^M, ℝ)` が実対称正定値であることと `ℝ^{2^M}` のユークリッドノルムを
使って `‖Wx‖ ≤ c‖x‖` と `m_k² ≤ m_{k-1}m_{k+1}` を示す。しかし証明が使っているのは

1. 係数が**順序体**であること、
2. 「内積」が**対称半正定値双線型形式**であること、
3. `W` がその形式について**自己共役**かつ**半正定値**であること（下からの評価では正定値）

の 3 つだけである。**実数であること・完備性・平方根・有限次元性・行列であること・
スペクトル定理は一切効いていない。**

とくに人手証明の `‖Wx‖ ≤ c‖x‖`（平方根を含む形）は、平方根を取る前の
`⟪Wx, Wx⟫ ≤ c²⟪x, x⟫` の形で順序体の上で成り立つ。平方根が要るのは
「ノルム」という言い方をするためだけであって、証明の内容ではない。

なお `c` の存在（上限 `sup` が取れること）と、跡による下からの評価だけは
ℝ の完備性・平方根を使うので、具体版の側（`Part011`）に置いてある。
-/
import Ising2D.Abstract.PsdCauchySchwarz

namespace Ising2D.Abstract

variable {R V : Type*} [Field R] [LinearOrder R] [IsStrictOrderedRing R]
  [AddCommGroup V] [Module R V]

/-- 「対称半正定値双線型形式 `ip` と、それについて自己共役かつ半正定値な作用素 `W`」の組。

人手証明の `W_is_real_symmetric_positive_definite` のうち、上からの評価に必要な部分だけを
取り出したもの。 -/
structure IsPsdPair (ip : V →ₗ[R] V →ₗ[R] R) (W : V →ₗ[R] V) : Prop where
  /-- `ip` は対称: `⟪u, v⟫ = ⟪v, u⟫` -/
  ip_symm : ∀ u v, ip u v = ip v u
  /-- `ip` は半正定値: `0 ≤ ⟪u, u⟫` -/
  ip_psd : ∀ u, 0 ≤ ip u u
  /-- `W` は自己共役: `⟪u, W v⟫ = ⟪W u, v⟫` -/
  W_selfadjoint : ∀ u v, ip u (W v) = ip (W u) v
  /-- `W` は半正定値: `0 ≤ ⟪u, W u⟫` -/
  W_psd : ∀ u, 0 ≤ ip u (W u)

/-- 上の組がさらに正定値であるもの。下からの評価（モーメント列の正値性）に必要。 -/
structure IsPdPair (ip : V →ₗ[R] V →ₗ[R] R) (W : V →ₗ[R] V) : Prop extends IsPsdPair ip W where
  /-- `ip` は正定値 -/
  ip_pos : ∀ u, u ≠ 0 → 0 < ip u u
  /-- `W` は正定値 -/
  W_pos : ∀ u, u ≠ 0 → 0 < ip u (W u)

namespace IsPsdPair

variable {ip : V →ₗ[R] V →ₗ[R] R} {W : V →ₗ[R] V}

/-- `ip` に対する Cauchy–Schwarz（`psd_cauchy_schwarz` の `P = I` の場合に対応）。 -/
theorem cs_ip (h : IsPsdPair ip W) (x y : V) :
    (ip y x) ^ 2 ≤ (ip x x) * (ip y y) :=
  psd_cauchy_schwarz ip h.ip_symm h.ip_psd x y

/-- `(u, v) ↦ ⟪u, W v⟫` に対する Cauchy–Schwarz（`psd_cauchy_schwarz` の `P = W` の場合）。 -/
theorem cs_W (h : IsPsdPair ip W) (x y : V) :
    (ip y (W x)) ^ 2 ≤ (ip x (W x)) * (ip y (W y)) := by
  have hsymm : ∀ u v, (ip.compl₂ W) u v = (ip.compl₂ W) v u := by
    intro u v
    simp only [LinearMap.compl₂_apply]
    rw [h.W_selfadjoint u v, h.ip_symm]
  have hpsd : ∀ u, 0 ≤ (ip.compl₂ W) u u := by
    intro u
    simpa only [LinearMap.compl₂_apply] using h.W_psd u
  simpa only [LinearMap.compl₂_apply] using
    psd_cauchy_schwarz (ip.compl₂ W) hsymm hpsd x y

/-- **Rayleigh 商による作用素の評価（抽象版）**。

`⟪u, W u⟫ ≤ c⟪u, u⟫`（すべての `u`）ならば `⟪W x, W x⟫ ≤ c²⟪x, x⟫`。

人手証明 `rayleigh_bounds_operator_norm` の `‖Wx‖ ≤ c‖x‖` は、両辺を 2 乗した形の
これと同値である（平方根は証明に使っていない）。 -/
theorem rayleigh_bounds_operator_norm (h : IsPsdPair ip W) {c : R} (hc0 : 0 ≤ c)
    (hc : ∀ u, ip u (W u) ≤ c * ip u u) (x : V) :
    ip (W x) (W x) ≤ c ^ 2 * ip x x := by
  have key : (ip (W x) (W x)) ^ 2 ≤ (ip x (W x)) * (ip (W x) (W (W x))) := h.cs_W x (W x)
  have h1 : ip x (W x) ≤ c * ip x x := hc x
  have h2 : ip (W x) (W (W x)) ≤ c * ip (W x) (W x) := hc (W x)
  have hbound : (ip x (W x)) * (ip (W x) (W (W x)))
      ≤ (c * ip x x) * (c * ip (W x) (W x)) := by
    refine mul_le_mul h1 h2 (h.W_psd (W x)) ?_
    exact mul_nonneg hc0 (h.ip_psd x)
  have hN : (ip (W x) (W x)) ^ 2 ≤ (c ^ 2 * ip x x) * (ip (W x) (W x)) := by
    calc (ip (W x) (W x)) ^ 2 ≤ (ip x (W x)) * (ip (W x) (W (W x))) := key
      _ ≤ (c * ip x x) * (c * ip (W x) (W x)) := hbound
      _ = (c ^ 2 * ip x x) * (ip (W x) (W x)) := by ring
  rcases eq_or_lt_of_le (h.ip_psd (W x)) with hzero | hpos
  · rw [← hzero]
    exact mul_nonneg (sq_nonneg c) (h.ip_psd x)
  · have := hN
    rw [sq] at this
    exact le_of_mul_le_mul_right (by linarith [this]) hpos

/-- 上の反復版: `⟪W^k x, W^k x⟫ ≤ (c²)^k ⟪x, x⟫`。

人手証明の「`k` に関する帰納法：`‖W^{k+1}x‖ = ‖W(W^kx)‖ ≤ c‖W^kx‖ ≤ c·c^k‖x‖`」に対応。 -/
theorem rayleigh_bounds_operator_norm_pow (h : IsPsdPair ip W) {c : R} (hc0 : 0 ≤ c)
    (hc : ∀ u, ip u (W u) ≤ c * ip u u) (k : ℕ) (x : V) :
    ip ((W ^ k) x) ((W ^ k) x) ≤ (c ^ 2) ^ k * ip x x := by
  induction k with
  | zero => simp
  | succ k ih =>
      have hstep : ip (W ((W ^ k) x)) (W ((W ^ k) x))
          ≤ c ^ 2 * ip ((W ^ k) x) ((W ^ k) x) :=
        h.rayleigh_bounds_operator_norm hc0 hc ((W ^ k) x)
      have happ : (W ^ (k + 1)) x = W ((W ^ k) x) := by
        rw [pow_succ']
        rfl
      rw [happ]
      calc ip (W ((W ^ k) x)) (W ((W ^ k) x))
          ≤ c ^ 2 * ip ((W ^ k) x) ((W ^ k) x) := hstep
        _ ≤ c ^ 2 * ((c ^ 2) ^ k * ip x x) := by
              exact mul_le_mul_of_nonneg_left ih (by positivity)
        _ = (c ^ 2) ^ (k + 1) * ip x x := by ring

/-- モーメント `m_k := ⟪x, W^k x⟫` を `⟪W^p x, W^q x⟫` の形へ分解する（`p + q = k`）。

自己共役性だけから従う。 -/
theorem moment_split (h : IsPsdPair ip W) (x : V) (p q : ℕ) :
    ip ((W ^ p) x) ((W ^ q) x) = ip x ((W ^ (p + q)) x) := by
  induction p generalizing q with
  | zero => simp
  | succ p ih =>
      have happ : (W ^ (p + 1)) x = W ((W ^ p) x) := by
        rw [pow_succ']
        rfl
      have happ' : (W ^ (q + 1)) x = W ((W ^ q) x) := by
        rw [pow_succ']
        rfl
      have he : p + (q + 1) = p + 1 + q := by omega
      rw [happ, ← h.W_selfadjoint ((W ^ p) x) ((W ^ q) x), ← happ', ih (q + 1), he]

end IsPsdPair

namespace IsPdPair

variable {ip : V →ₗ[R] V →ₗ[R] R} {W : V →ₗ[R] V}

omit [IsStrictOrderedRing R] in
/-- 正定値なら `W` の核は `{0}`（人手証明の「可逆性」に対応）。 -/
theorem W_ker (h : IsPdPair ip W) {u : V} (hu : W u = 0) : u = 0 := by
  by_contra hne
  have := h.W_pos u hne
  rw [hu, map_zero] at this
  exact lt_irrefl _ this

theorem pow_ne_zero_of_ne_zero (h : IsPdPair ip W) {x : V} (hx : x ≠ 0) (p : ℕ) :
    (W ^ p) x ≠ 0 := by
  induction p with
  | zero => simpa using hx
  | succ p ih =>
      have happ : (W ^ (p + 1)) x = W ((W ^ p) x) := by
        rw [pow_succ']
        rfl
      rw [happ]
      intro hcon
      exact ih (h.W_ker hcon)

/-- モーメント列は正: `0 < ⟪x, W^k x⟫`（`x ≠ 0`）。

人手証明の Step 2 冒頭「`k = 2a` なら `m_k = ‖W^a x‖² > 0`、`k = 2a+1` なら
`m_k = (W^a x)ᵀ W (W^a x) > 0`」に対応。 -/
theorem moment_pos (h : IsPdPair ip W) {x : V} (hx : x ≠ 0) (k : ℕ) :
    0 < ip x ((W ^ k) x) := by
  rcases Nat.even_or_odd k with ⟨p, hp⟩ | ⟨p, hp⟩
  · subst hp
    rw [← h.toIsPsdPair.moment_split x p p]
    exact h.ip_pos _ (h.pow_ne_zero_of_ne_zero hx p)
  · subst hp
    have he : 2 * p + 1 = p + (p + 1) := by omega
    rw [he, ← h.toIsPsdPair.moment_split x p (p + 1)]
    have happ : (W ^ (p + 1)) x = W ((W ^ p) x) := by
      rw [pow_succ']
      rfl
    rw [happ]
    exact h.W_pos _ (h.pow_ne_zero_of_ne_zero hx p)

end IsPdPair

namespace IsPsdPair

variable {ip : V →ₗ[R] V →ₗ[R] R} {W : V →ₗ[R] V}

/-- モーメント列は非負。 -/
theorem moment_nonneg (h : IsPsdPair ip W) (x : V) (k : ℕ) :
    0 ≤ ip x ((W ^ k) x) := by
  rcases Nat.even_or_odd k with ⟨p, hp⟩ | ⟨p, hp⟩
  · subst hp
    rw [← h.moment_split x p p]
    exact h.ip_psd _
  · subst hp
    have he : 2 * p + 1 = p + (p + 1) := by omega
    rw [he, ← h.moment_split x p (p + 1)]
    have happ : (W ^ (p + 1)) x = W ((W ^ p) x) := by
      rw [pow_succ']
      rfl
    rw [happ]
    exact h.W_psd _

/-- **モーメント列の上からの評価**: `m_k ≤ c^k ⟪x, x⟫`。

人手証明 `trace_power_sandwich` の Step 1（`e_kᵀ W^n e_k ≤ c^n` の偶奇の場合分け）に対応。 -/
theorem moment_le_pow (h : IsPsdPair ip W) {c : R} (hc0 : 0 ≤ c)
    (hc : ∀ u, ip u (W u) ≤ c * ip u u) (x : V) (k : ℕ) :
    ip x ((W ^ k) x) ≤ c ^ k * ip x x := by
  rcases Nat.even_or_odd k with ⟨p, hp⟩ | ⟨p, hp⟩
  · subst hp
    rw [← h.moment_split x p p]
    have hpow : (c ^ 2) ^ p = c ^ (p + p) := by
      rw [← pow_mul]
      congr 1
      omega
    calc ip ((W ^ p) x) ((W ^ p) x) ≤ (c ^ 2) ^ p * ip x x :=
          h.rayleigh_bounds_operator_norm_pow hc0 hc p x
      _ = c ^ (p + p) * ip x x := by rw [hpow]
  · subst hp
    have he : 2 * p + 1 = p + (p + 1) := by omega
    rw [he, ← h.moment_split x p (p + 1)]
    have happ : (W ^ (p + 1)) x = W ((W ^ p) x) := by
      rw [pow_succ']
      rfl
    rw [happ]
    have hstep : ip ((W ^ p) x) (W ((W ^ p) x)) ≤ c * ip ((W ^ p) x) ((W ^ p) x) :=
      hc ((W ^ p) x)
    have hpow2 : ip ((W ^ p) x) ((W ^ p) x) ≤ (c ^ 2) ^ p * ip x x :=
      h.rayleigh_bounds_operator_norm_pow hc0 hc p x
    have hfinal : c * ip ((W ^ p) x) ((W ^ p) x) ≤ c * ((c ^ 2) ^ p * ip x x) :=
      mul_le_mul_of_nonneg_left hpow2 hc0
    have hpow : c * ((c ^ 2) ^ p * ip x x) = c ^ (p + (p + 1)) * ip x x := by
      have h1 : (c ^ 2) ^ p = c ^ (p + p) := by
        rw [← pow_mul]
        congr 1
        omega
      have h2 : p + (p + 1) = p + p + 1 := by omega
      rw [h1, h2, pow_succ]
      ring
    calc ip ((W ^ p) x) (W ((W ^ p) x)) ≤ c * ip ((W ^ p) x) ((W ^ p) x) := hstep
      _ ≤ c * ((c ^ 2) ^ p * ip x x) := hfinal
      _ = c ^ (p + (p + 1)) * ip x x := hpow

/-- **モーメント列の対数凸性**: `m_{k+1}² ≤ m_k · m_{k+2}`。

人手証明 `trace_power_sandwich` の Step 2。偶奇で `P = I` の Cauchy–Schwarz と
`P = W` の Cauchy–Schwarz を使い分ける。

（人手証明の括弧書き「`a = k-1`、`b = k+1` の場合」は添字の書き誤りで、
正しくは `k+1` が奇数なら `(a, b) = (k/2, k/2+1)` で `P = I` 版、
`k+1` が偶数なら `(a, b) = ((k-1)/2, (k+1)/2)` で `P = W` 版を使う。
本ファイルの証明はこの正しい添字で書いてある。） -/
theorem moment_log_convex (h : IsPsdPair ip W) (x : V) (k : ℕ) :
    (ip x ((W ^ (k + 1)) x)) ^ 2
      ≤ (ip x ((W ^ k) x)) * (ip x ((W ^ (k + 2)) x)) := by
  rcases Nat.even_or_odd k with ⟨p, hp⟩ | ⟨p, hp⟩
  · -- `k = p + p` は偶数、`k + 1` は奇数 ⇒ `P = I` 版
    subst hp
    have hcs := h.cs_ip ((W ^ p) x) ((W ^ (p + 1)) x)
    rw [h.moment_split x (p + 1) p, h.moment_split x p p,
      h.moment_split x (p + 1) (p + 1)] at hcs
    rw [show p + 1 + p = p + p + 1 from by omega,
      show p + 1 + (p + 1) = p + p + 2 from by omega] at hcs
    exact hcs
  · -- `k = 2p+1` は奇数、`k + 1` は偶数 ⇒ `P = W` 版
    subst hp
    have happ : ∀ m : ℕ, W ((W ^ m) x) = (W ^ (m + 1)) x := by
      intro m
      rw [pow_succ']
      rfl
    have hcs := h.cs_W ((W ^ p) x) ((W ^ (p + 1)) x)
    rw [happ p, happ (p + 1)] at hcs
    rw [h.moment_split x (p + 1) (p + 1), h.moment_split x p (p + 1),
      h.moment_split x (p + 1) (p + 1 + 1)] at hcs
    rw [show p + 1 + (p + 1) = 2 * p + 1 + 1 from by omega,
      show p + (p + 1) = 2 * p + 1 from by omega,
      show p + 1 + (p + 1 + 1) = 2 * p + 1 + 2 from by omega] at hcs
    exact hcs

end IsPsdPair

namespace IsPdPair

variable {ip : V →ₗ[R] V →ₗ[R] R} {W : V →ₗ[R] V}

/-- 比 `m_{k+1}/m_k` が非減少であることの言い換え: `m_1 · m_k ≤ m_{k+1}`（`m_0 = 1`）。

人手証明 `trace_power_sandwich` の Step 3 前半。 -/
theorem moment_ratio_le (h : IsPdPair ip W) {x : V} (hx : x ≠ 0) (hx1 : ip x x = 1) (k : ℕ) :
    (ip x ((W ^ 1) x)) * (ip x ((W ^ k) x)) ≤ ip x ((W ^ (k + 1)) x) := by
  induction k with
  | zero =>
      simp [hx1]
  | succ k ih =>
      have hk : 0 < ip x ((W ^ k) x) := h.moment_pos hx k
      have hk1 : 0 < ip x ((W ^ (k + 1)) x) := h.moment_pos hx (k + 1)
      have hlog := h.toIsPsdPair.moment_log_convex x k
      -- `m1 * m(k+1) * mk ≤ m(k+1)^2 ≤ mk * m(k+2)` から `mk > 0` で割る
      have step1 : (ip x ((W ^ 1) x)) * (ip x ((W ^ (k + 1)) x)) * (ip x ((W ^ k) x))
          ≤ (ip x ((W ^ (k + 1)) x)) ^ 2 := by
        have := mul_le_mul_of_nonneg_right ih (le_of_lt hk1)
        nlinarith [this]
      have step2 : (ip x ((W ^ 1) x)) * (ip x ((W ^ (k + 1)) x)) * (ip x ((W ^ k) x))
          ≤ (ip x ((W ^ (k + 1 + 1)) x)) * (ip x ((W ^ k) x)) := by
        have e : k + 2 = k + 1 + 1 := by omega
        rw [← e]
        nlinarith [step1, hlog]
      exact le_of_mul_le_mul_right step2 hk

/-- **`(x ᵀ W x)^n ≤ m_n`**（`x` は単位ベクトル）。

人手証明 `trace_power_sandwich` の Step 3 の
`m_n = (m_n/m_{n-1})⋯(m_1/m_0) ≥ (m_1/m_0)^n = (xᵀWx)^n` に対応する。 -/
theorem moment_pow_le (h : IsPdPair ip W) {x : V} (hx : x ≠ 0) (hx1 : ip x x = 1) (n : ℕ) :
    (ip x (W x)) ^ n ≤ ip x ((W ^ n) x) := by
  have hW1 : ip x ((W ^ 1) x) = ip x (W x) := by
    simp
  induction n with
  | zero => simp [hx1]
  | succ n ih =>
      have hratio := h.moment_ratio_le hx hx1 n
      rw [hW1] at hratio
      have hpos1 : 0 ≤ ip x (W x) := h.W_psd x
      calc (ip x (W x)) ^ (n + 1) = (ip x (W x)) * (ip x (W x)) ^ n := by ring
        _ ≤ (ip x (W x)) * (ip x ((W ^ n) x)) := by
              exact mul_le_mul_of_nonneg_left ih hpos1
        _ ≤ ip x ((W ^ (n + 1)) x) := hratio

end IsPdPair

end Ising2D.Abstract
