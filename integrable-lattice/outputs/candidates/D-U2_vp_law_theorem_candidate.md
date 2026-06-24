# 定理候補 (D-U2): 可積分転送行列の Massieu Φ の p 進構造法則

Source: `sagemath/check/D-U2_padic_law/`, `sagemath/check/potts_phi/`（SageMath 検証済）。
分類: 方向 D（Massieu Φ∈Λ）× 整数論。選別基準 (i)-(iv) 適合（Λ/ℚ̄, ℝ不使用, 決定可能, 単一構造）。

```yaml
id: D-U2-vp-newton-polygon-law
title: 整数転送行列の Massieu Φ_N=log Z_N の ℓ_p 係数は固有値 p 進 Newton 多角形で支配される
status: theorem_candidate
direction: D
model: 整数 Boltzmann 重みをもつ可積分格子模型(六頂点, Potts, … 整数転送行列をもつもの)
target_quantity: Φ_N=log Z_N の ℓ_p 係数 = v_p(Z_N),  Z_N=Tr T^N
home: Λ (ℓ_p 係数は ℤ)
parameters: [integer_weights, finite_L, all_primes_p]

statement: >
  T∈M_d(ℤ) を整数重みの可積分模型の(列 L 固定)転送行列、Z_N=Tr T^N∈ℤ_{>0}、
  Φ_N=log Z_N∈Λ とする。各素数 p に対し μ_min(p) を char_T(x)∈ℤ[x] の
  p 進 Newton 多角形の最小傾き(=固有値の最小 p 進付値)とすると、
    v_p(Z_N) = μ_min(p)·N + r_p(N),
  ここで r_p(N) は N について **最終周期的**。ただし、等 p 進付値の固有値の部分和が
  高位で消える有限/疎な「例外指数」(Skolem–Mahler–Lech)で r_p はスパイクしうる。
  μ_min(p)・周期・任意上限までの例外指数は、すべて T から ℤ 上で決定可能
  (Newton 多角形 + 線形漸化 mod p^k)。ℝ は使用しない。

duality_remark: >
  同一の固有値集合が二面を支配する:
   - ℝ 側: 自由エネルギー密度 −βf = lim (1/NL) log Z_N = (1/L) log λ_max
     (絶対値最大=Perron 固有値)。解析・連続極限。
   - Λ 側: Φ_N の素因数構造 v_p(Z_N) = μ_min(p)·N + 周期
     (最小 p 進付値の固有値=Newton 多角形)。可算・決定可能。
  「絶対値」が ℝ 側(自由エネルギー)、「p 進付値」が Λ 側(Φ の数論)を支配。

finite_symbol_process: charpoly の p 進 Newton 多角形 + Z_N の整数線形漸化(mod p^k 周期)。
decidable: yes (Newton 多角形, 線形漸化 mod p^k はアルゴリズム的)
formal_verifiable: partial (各 p, 各上限で決定手続き; 一般の周期上界は SML 由来で非自明)
small_case_experiment: 済(六頂点 (1,1,2) で v_2=N+2 等, Potts q=3 で族横断確認)

resolved_risk: >
  unchecked-but-likely-known(部分): 「線形漸化列の p 進付値が eventually periodic」は
  整数論の既知主題(線形漸化の p 進解析, SML)。本候補の差分は (a) 可積分転送行列の
  Massieu Φ∈Λ への適用, (b) μ_min の Newton 多角形公式, (c) 族横断普遍性(六頂点/Potts),
  (d) ℝ/Λ の固有値双対 の明示。深い新数論ではなく構造的・適用的定理。
novelty_risk: >
  unchecked。SML 例外の存在で「完全な閉形式」は一般に無い。特殊素数 p|q(対称性位数)で
  周期増大。厳密化はこれらの caveat 込みでのみ可能。
paper_potential: low-medium(基礎論/構造寄り。新規性は適用と双対の明示に依存)
references: [線形漸化列の p 進付値(古典), Skolem–Mahler–Lech, 09_2DIsing, 04_分配関数と自由エネルギー]
notes: >
  cycle 2 の主成果。正直に「既知 p 進理論の可積分 Φ への適用＋双対の明示」で、
  可積分の新厳密解ではない。論文化するなら基礎論/数論的構造ノートとして。
```

## 厳密化に向けた未確定点（cycle 3 候補）

- r_p の周期の上界（固有値の乗法的順序 mod p^k から）を SML 例外込みで明示。
- 特殊素数 p|q（対称性位数）の周期増大の機構を Potts で定式化。
- ℝ/Λ 双対（λ_max vs μ_min）を一般の整数転送行列で命題化。
- カイラル Potts τ^(2)（本命）への直接適用は未（六頂点・Potts で普遍性は実証）。
