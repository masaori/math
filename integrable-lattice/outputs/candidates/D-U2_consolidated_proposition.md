# D-U2 統合命題（確定版）: 整数転送行列の Massieu Φ の p 進周期構造

トラック横断（T1 Reframe × T3 Pure）の確定成果。cycle 3–8 の検証（`sagemath/check/`: `D-U2_padic_law`, `cycle3_T1_period_bound`, `cycle3_T3_period/*`）を1命題に統合。
選別基準 (i)–(iv) 適合（Λ/ℚ̄, ℝ不使用, 決定可能, 形式検証可能）。

## 設定

$T\in M_d(\mathbb{Z})$（整数重みの可積分模型の転送行列, 列 $L$ 固定）、$Z_N=\mathrm{Tr}\,T^N\in\mathbb{Z}$、
$\Phi_N=\log|Z_N|\in\Lambda$（$Z_N\ne0$）。固有値 $\{\lambda_i\}\subset\overline{\mathbb{Q}}$、$\chi_T\in\mathbb{Z}[x]$。
素数 $p$ に対し $v_p(Z_N)\in\mathbb{Z}_{\ge0}$ が $\Phi_N$ の $\ell_p$ 係数。

## 命題（確定・rigorous な部分と、否定された部分を明示）

以下 $p\nmid\det T$（$T\bmod p$ 可逆）とする。

**(A) 周期性（cycle3, 証明済）.** 任意の切断 $k\ge1$ で $\min(v_p(Z_N),k)$ は $N$ について最終周期的で、周期は
$\pi(p,k):=(T^N\bmod p^k\text{ の最終周期})$ を割る。$\pi(p,k)$ は有限モノイド $M_d(\mathbb{Z}/p^k)$ で決定可能。

**(B) $\pi(p,1)$ の精密公式（cycle8, 証明: 指標の一次独立）.**
$$\pi(p,1)=\mathrm{lcm}\{\mathrm{ord}(\lambda):\lambda\in\overline{\mathbb{F}_p}^\times\text{ 相異固有値},\ p\nmid m_\lambda\}$$
（$m_\lambda$＝代数的重複度, $\mathrm{ord}$＝$\overline{\mathbb{F}_p}^\times$ 乗法的順序）。重複度 $p\mid m_\lambda$ の固有値はトレース $\bmod p$ から脱落。

**(C) 上界（既知 Pisano 理論）.** $\pi(p,k)\mid p^{k-1}\pi(p,1)$。合わせて
$$\pi(p,k)\ \big|\ p^{k-1}\cdot\mathrm{lcm}\{\mathrm{ord}(\lambda):p\nmid m_\lambda\}\ \ (\text{決定可能・閉形上界}).$$

**(D) 線形成長（Newton 多角形, cycle3-4）.** $v_p(Z_N)$ の $N$ 線形成長率は
$\mu_{\min}(p)=\chi_T$ の $p$ 進 Newton 多角形の最小傾き＝固有値の最小 $p$ 進付値。
（$p\nmid\det T$ なら $\mu_{\min}=0$。$p\mid\det T$ の側は別途。）

**(否定) Wall 等式は不成立（cycle6, 反例多数）.** $\pi(p,k)=p^{k-1}\pi(p,1)$ は一般・可積分とも**成り立たない**（六頂点 572 件中 4.5% 破れ, Pell p=13 等）。よって (C) は「割り切る」でのみ rigorous、等号ではない。

## 決定可能性・形式検証

- $\pi(p,1)$, $\mu_{\min}(p)$, 周期構造は $\mathbb{Z}$/有限体上の有限計算（charpoly の $\bmod p$ 分解・根の order・Newton 多角形）で**決定可能**。
- 各命題は $\mathbb{Z}/p^k$・$\overline{\mathbb{F}_p}$ の初等計算に帰着し **`decide`/reflection 可能（RCA₀）**、witness = (固有値の order と重複度, $N_0$, 周期表)。
- Lean 仕様: `π(p,1) = lcm { ord λ | λ ∈ eigenvalues(T mod p), p ∤ mult λ }`（Mathlib の有限体・多項式分解・`multiplicative_order` で構成可能）。

## ℝ/Λ 双対（cross-ref）

同一 $\chi_T$（or スペクトル曲線 $P$）の固有値集合が、ℝ側の自由エネルギー（$\log\lambda_{\max}$/Mahler 測度, cycle4,9）と Λ側の $\Phi$ 周期構造（本命題）を同時に支配。ℝ側＝アルキメデス Mahler（既知 LSW）、Λ側＝本命題（決定可能）。詳細 `docs/research/R-Lambda-duality/`, `outputs/reports/cycle4_T1_R_Lambda_mahler.md`, `cycle6_T1_padic_mahler_grounding.md`。

## 位置づけ（正直に）

- 中身は既知の数論（線形漸化列の周期・Pisano・LTE・Mahler 測度）を可積分転送行列の Massieu $\Phi\in\Lambda$ に**適用・可算化・形式検証可能化**したもの（T1 Reframe の性質）。**新しい深い数論ではない**。
- 価値: 統計力学の有限サイズ自由エントロピーの素因数構造を、**完全に決定可能・witness 付き・Lean 化可能**な命題群として確定したこと。Wall のような「魅力的だが偽」の枝を統計的・構成的に刈り取った点も含め、誠実に固めた。
