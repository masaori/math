# Onsager 閉形式を既存の極限と同定し臨界点へ接続する

## 概要

有限モード和から得た積分を現在の変数 `x` と正規化で Onsager 閉形式として明記し、既存の周期境界自由エントロピー密度と同定する。さらに分散の隙間が閉じる点が、既に代数的に定義した唯一の正の Kramers--Wannier 不動点であることを証明する。

## 到達すべき式（2026-10-09 の研究管理の決定）

前段の積分を本文の規約で正規化すると、$q\in\mathbb Q_{(0,1)}$ について
$$\rho_{\mathbb R}\bigl(\phi(q)\bigr)=\frac{1}{8\pi^2}\int_0^{2\pi}\!\!\int_0^{2\pi}\log\Bigl[(1+q^2)^2-2q(1-q^2)(\cos\theta_1+\cos\theta_2)\Bigr]d\theta_1\,d\theta_2$$
（$\phi(q)$ は `def_periodic_free_energy_density_le_one` の密度）。Onsager の形との対応は、代数的略記 $\cosh2K:=(1+q^2)/(2q)$、$\sinh2K:=(1-q^2)/(2q)$（[分散因子の指示書](compute-square-lattice-dispersion-factor.md)）で被対数を $4q^2\bigl[\cosh^22K-\sinh2K(\cos\theta_1+\cos\theta_2)\bigr]$ と書き直して
$$\rho_{\mathbb R}\bigl(\phi(q)\bigr)=\log2+\log q+\frac{1}{8\pi^2}\int_0^{2\pi}\!\!\int_0^{2\pi}\log\bigl[\cosh^22K-\sinh2K(\cos\theta_1+\cos\theta_2)\bigr]d\theta_1\,d\theta_2 .$$
本文の $Z_L(x)=\sum_\sigma x^{m(\sigma)}$ は、物理の分配関数 $\sum_\sigma e^{K\sum_e\sigma\sigma'}$ と $\sum_e\sigma\sigma'=2L^2-2m(\sigma)$ により $x=e^{-2K}$ で $x^{-L^2}Z_L(x)$ の関係にあるので、右辺から $\log q$ を除いたものが Onsager の $-\beta f=\log2+\frac{1}{8\pi^2}\iint\log[\cosh^22K-\sinh2K(\cos\theta_1+\cos\theta_2)]$ である。前因子の対応はこの一行で尽きる（$2^{L^2}$ も $(1+x)^{2L^2}$ も現れない。有限トーラス公式を低温変数のまま書いたため）。
臨界点: 被対数の最小値は $\theta_1=\theta_2=0$ での $(1-2q-q^2)^2$ で、これが零になる条件が自己双対方程式 $\xi^2+2\xi-1=0$、正錐での唯一の根が $x_c=-1+s$（`claim_self_dual_positive_root_unique`）。非解析性は実数側で、積分の $q$ についての微分可能性の破れとして別ブロックで述べる。

## 密度との同定の橋（2026-10-10 の研究管理の決定）

本文の密度 `def_periodic_free_energy_density_le_one` は、列 $(\Psi_L(q))_{L\ge1}\subset\Lambda_{\mathbb Q}$（`def_finite_free_entropy_density`）が定める下組 $A^{\mathrm{per}}(q)$（`def_periodic_density_lower_set`、一般形は `def_rational_log_order_group_sequence_lower_set`）の実現像 $\rho_{\mathbb R}(A^{\mathrm{per}}(q))$ の上限 $f^{\mathrm{per}}(q)$ として定義されている。前段（[有限モード和から Onsager 積分へ脱出する](pass-from-mode-sums-to-integral.md)）が与えるのは列の実現 $\rho_{\mathbb R}(\Psi_L(q))$ の実数極限なので、両者を結ぶ主張が一つ要る。本文にはまだ無い。

**橋（一般の列について述べる。実数体への脱出: 連続極限）。** $(\lambda_L)_{L\ge1}$ を $\Lambda_{\mathbb Q}$ の列、$I\in\mathbb R$ を実数とし、実数の列 $(\rho_{\mathbb R}(\lambda_L))_{L\ge1}$ が $I$ へ収束するとする。このとき $\rho_{\mathbb R}(A((\lambda_L)_{L\ge1}))$ は空でなく上に有界で、
$$\sup\rho_{\mathbb R}\bigl(A((\lambda_L)_{L\ge1})\bigr)=I .$$

- **上から。** $\mu\in A((\lambda_L))$ の証人 $\varepsilon,N$ を取る。$0\le_{\Lambda_{\mathbb Q}}\varepsilon$ と加法の単調性 `claim_rational_log_order_group_add_monotone` から $\mu\le_{\Lambda_{\mathbb Q}}\mu+\varepsilon\le_{\Lambda_{\mathbb Q}}\lambda_L$（$L\ge N$）。実現の単調性 `claim_rational_log_order_group_realization_monotone` から $\rho_{\mathbb R}(\mu)\le\rho_{\mathbb R}(\lambda_L)$（$L\ge N$）。実数の列の極限は $\le$ を保つので $\rho_{\mathbb R}(\mu)\le I$。よって $I$ は上界であり、$\sup\le I$。
- **下から。** 任意の実数 $\eta>0$ を取る。$\mathbb R$ の Archimedes 性で $n\in\mathbb N$、$n\ge1$ を $\log_{\mathbb R}2/n<\eta/2$ に取ると、長さ $\eta$ の開区間 $(I-\eta,I)$ は幅 $\log_{\mathbb R}2/n$ の格子点を二つ続けて含むので、整数 $k$ で $I-\eta<(k/n)\log_{\mathbb R}2$ かつ $((k+1)/n)\log_{\mathbb R}2<I$ を満たすものがある。$\mu:=(k/n)\cdot\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\ell_2)$、$\varepsilon:=(1/n)\cdot\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\ell_2)$（`def_rational_log_order_group` の有理数倍）と置く。$\mu+\varepsilon=((k+1)/n)\cdot\iota(\ell_2)$ であり、`claim_rational_log_order_group_realization_smul` と `claim_log_order_group_realization_real_log`（$\rho_{\mathbb R}(\iota(\ell_2))=\log_{\mathbb R}2$）から $\rho_{\mathbb R}(\mu)=(k/n)\log_{\mathbb R}2$、$\rho_{\mathbb R}(\mu+\varepsilon)=((k+1)/n)\log_{\mathbb R}2<I$。収束の定義から、ある $N$ で $L\ge N$ なら $\rho_{\mathbb R}(\lambda_L)>\rho_{\mathbb R}(\mu+\varepsilon)$。全順序性 `claim_rational_log_order_group_linear_order` と実現の単調性から $\mu+\varepsilon\le_{\Lambda_{\mathbb Q}}\lambda_L$（そうでなければ $\lambda_L\le_{\Lambda_{\mathbb Q}}\mu+\varepsilon$、実現して $\rho_{\mathbb R}(\lambda_L)\le\rho_{\mathbb R}(\mu+\varepsilon)$ となり矛盾）。$0\le_{\Lambda_{\mathbb Q}}\varepsilon$ と $\varepsilon\ne0$ は `claim_rational_embedded_log_order_iff`（$q:=1$、$q':=2$）と `claim_rational_log_order_group_nonneg_scalar_monotone`、および $\iota$ の単射性 `claim_rational_log_order_group_embedding`。よって $\mu\in A((\lambda_L))$ で $\rho_{\mathbb R}(\mu)>I-\eta$。$\eta$ は任意なので $\sup\ge I$。
- 実現写像の加法性は本文に無い（`def_rational_log_order_group_realization` は「この先の議論が使わないので述べない」としている）。証人を $\iota(\ell_2)$ の有理数倍に取るので要らない。足さない。
- 実数側で使うのは、実数の列の極限の定義、極限が $\le$ を保つこと、Archimedes 性だけである。上限の存在は `def_periodic_free_energy_density_le_one` が完備性で既に取ってあるので、この節の脱出理由は「連続極限」とする。
- Ising を参照しない一般の主張だが、実数体へ脱出するので道具の章ではなく「実数体への脱出と熱力学極限」の章（`def_open_square_free_energy_density` の近く）に置く。

**同定への適用。** [四つのねじれが同じ熱力学極限を持つことを証明する](prove-twists-share-thermodynamic-limit.md) の $\Lambda$ の鎖 $\log\max_{(a,b)}|Q^{a,b}_L(q)|-2\ell_2\le\Phi_L(q)\le\log\max_{(a,b)}|Q^{a,b}_L(q)|+\ell_2$ を、$\Lambda_{\mathbb Q}$ へ埋め込んで $1/L^2$ 倍し（`claim_rational_log_order_group_nonneg_scalar_monotone`）、実現すると（単調性・有理数倍・`claim_log_order_group_realization_real_log`）
$$\Bigl|\rho_{\mathbb R}\bigl(\Psi_L(q)\bigr)-\tfrac{1}{L^2}\log_{\mathbb R}\max_{(a,b)}|Q^{a,b}_L(q)|\Bigr|\le\frac{2\log_{\mathbb R}2}{L^2}.$$
前段により右の項は四つとも同じ積分 $I_q$ へ収束するので $\rho_{\mathbb R}(\Psi_L(q))\to I_q$。橋を $(\lambda_L):=(\Psi_L(q))$、$I:=I_q$ で読めば $f^{\mathrm{per}}(q)=\sup\rho_{\mathbb R}(A^{\mathrm{per}}(q))=I_q$ であり、これが「到達すべき式」の左辺 $\rho_{\mathbb R}(\phi(q))$ の意味である。

## 背景・前提

- モード和から積分へのタスクに依存する。
- `def_periodic_free_energy_density_le_one`, `def_critical_point`, `claim_kw_self_dual_quadratic_equivalence`, `claim_self_dual_positive_root_unique` を使う。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

閉形式との同定、臨界点の位置、非解析性の発生箇所を扱う。臨界指数の一般論へは広げない。

## 記号の帰属と ℝ 脱出の見込み

- 臨界点 `x_c` と分散零条件は `Qbar` で決まる。
- 積分値と非解析性は `R` に住み、積分・局所極限・実関数の解析性を理由として脱出する。

## 作業内容

### 閉形式の同定

- 現在の `Z_L(x)=Σσ x^{m(σ)}` の規約から前因子を導き、外部式を変数変換だけで貼り付けない。
- 積分表示が `def_periodic_free_energy_density_le_one` で定義済みの同じ実数に等しいことを証明する。

### 自己双対点と特異性

- 分散因子の零条件を代数的に `ξ²+2ξ-1=0` へ同値変形する。
- `1+ξ≠0` を先に証明してから `claim_kw_self_dual_quadratic_equivalence` を適用する。
- 正錐での一意性により `ξ=x_c` を得て、臨界点の位置が可算側、非解析性が実数側にあることを分離する。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`

## 完了条件

- [ ] 正規化済みの Onsager 積分表示が本文の主定理として証明されている。
- [ ] 既存の自由エントロピー密度との等号が証明されている。
- [ ] 分散零点、二次方程式、KW 不動点、正錐での一意性が前提を落とさず鎖になっている。
- [ ] 臨界点の代数的位置と非解析性の実数的主張が別ブロックである。
- [ ] 本文・SageMath linkage・Lean・PDF の全検証が通る。
