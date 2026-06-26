# cycle 4 / T1 Reframe: ℝ/Λ 双対の命題化（Mahler 測度による接地）

トラック1（Reframe）: ℝ/Λ 双対を、既知の **Mahler 測度＝自由エネルギー** 理論に接地し命題形にする。
研究ノート: root `docs/research/R-Lambda-duality/`。検証データ: cycle 2-3 の `sagemath/check/`。

## スペクトル曲線（共通の整数多項式）

整数重みの可積分模型で、Bloch 位相 $z$（水平方向の Fourier 変数）をもつ転送行列 $T(z)$ を考える。各成分は $z^{\pm1}$ の整係数 Laurent 多項式。**スペクトル曲線**
$$P(z,w)=\det\bigl(w\,I-T(z)\bigr)\in\mathbb{Z}[z^{\pm1},w].$$
有限 $L$ 周期では $z$ は $1$ の $L$ 乗根を走り、$Z_{N,L}=\sum_{z^L=1}\sum_i\lambda_i(z)^N$（$\lambda_i(z)$＝$T(z)$ の固有値）。

## ℝ 側（アルキメデス）— 既知・深い

自由エネルギー密度は **$P$ の Mahler 測度**:
$$-\beta f=\lim_{L,N\to\infty}\frac1{NL}\log Z_{N,L}=\log m(P),\quad
m(P)=\exp\!\int_{\mathbb{T}^2}\log|P(z,w)|\,\frac{dz}{2\pi i z}\frac{dw}{2\pi i w}.$$
- これは Lind–Schmidt–Ward（$\mathbb{Z}^d$ 作用の位相的エントロピー＝Mahler 測度）の格子模型版。
- **Ising では精密化済み**（arXiv:2407.19531, Phys. Rev. E 110, 054134, 2024）: 正方/三角/六角 Ising の自由エネルギーが Laurent 多項式の Mahler 測度。特殊温度で楕円曲線の Hasse–Weil $L$ 函数、臨界点で Dirichlet $L$ 函数。
- 住処は $\mathbb{R}$（積分・連続極限）。アルキメデス絶対値 $|\cdot|_\infty$ が支配。

## Λ 側（非アルキメデス/p 進）— 本プロジェクトの寄与・一部予想

同じ $P\in\mathbb{Z}[z^{\pm},w]$ の**有限 $L$・有限 $N$ 特殊化** $Z_{N,L}\in\mathbb{Z}$ の $p$ 進構造（D-U2）:
- $\Phi_{N,L}=\log Z_{N,L}\in\Lambda$、$\ell_p$ 係数 $v_p(Z_{N,L})=\mu_{\min}(p)N+r_p(N)$（命題 A・B, cycle 3）。
- $\mu_{\min}(p)$ は $T(z)$（特殊化後）の固有値の最小 $p$ 進付値＝$p$ 進 Newton 多角形。
- **予想（要証明）**: これは $P$ の **$p$ 進（非アルキメデス）Mahler 測度** の有限近似に対応する。$p$ 進 Mahler 測度・$p$ 進エントロピーは代数力学で研究がある（Besser–Deninger 系, 要文献精査）。

## ℝ/Λ 双対命題（命題形）

**命題（双対, 一部予想）**: 整数スペクトル曲線 $P\in\mathbb{Z}[z^{\pm},w]$ に対し、
- アルキメデス素点 $\infty$ での Mahler 測度 $\log m(P)$ ＝ 自由エネルギー密度（$\mathbb{R}$, 既知）。
- 各 $p$ 進素点での非アルキメデス Mahler 測度／Newton 多角形 ＝ 有限 $N$ Massieu $\Phi_{N,L}\in\Lambda$ の $\ell_p$ 構造の支配項（D-U2, 命題 A は厳密, $p$ 進 Mahler との同定は予想）。
- 両者は同一の整数多項式 $P$ の異なる素点での「測度」であり、積公式 $\prod_v\|\cdot\|_v=1$ の精神で結ばれる。

## 確立 / 予想 の切り分け（正直に）

- **確立（文献＋本検証）**: ℝ側＝アルキメデス Mahler 測度（Ising で精密, 一般に LSW）。Λ側の命題 A（$v_p$ の周期構造, 決定可能）。
- **予想（本プロジェクト固有, 未証明）**: Λ側の $v_p$ 構造＝$P$ の $p$ 進 Mahler 測度との厳密同定。adelic/積公式としての両側統合。
- 価値: 物理（自由エネルギー）と数論（Mahler 測度・$L$ 函数・$p$ 進）を、**同一整数多項式の素点ごとの測度**として統一する視点を、決定可能・形式検証可能な Λ 側から補強する（トラック1 Reframe の最深部）。

## 次（cycle 5+ / 研究ノート連携）

- $p$ 進 Mahler 測度（Besser–Deninger, $p$ 進エントロピー）の文献精査と $\mu_{\min}(p)$ との厳密対応。
- 六頂点・dimer のスペクトル曲線 $P(z,w)$ を明示し、$m(P)$（ℝ）と $v_p$（Λ）を同一 $P$ から計算して双対を実証（SageMath, cycle 5 候補）。
- `docs/research/R-Lambda-duality/` を本接地で更新（別途）。
