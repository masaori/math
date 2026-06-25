# cycle 3 / T1 Reframe: D-U2 の厳密命題化

検証: `sagemath/check/cycle3_T1_period_bound/`（全ケース・全素数で周期主張 True）。
位置づけ: 理論物理（可積分転送行列）の Massieu $\Phi$ の数論構造を、**決定可能で rigorous な命題**に書き換える（トラック1 Reframe）。

## 設定

$T\in M_d(\mathbb{Z})$ を整数 Boltzmann 重みの可積分模型の転送行列（列 $L$ 固定）、
$Z_N=\mathrm{Tr}\,T^N\in\mathbb{Z}_{>0}$、$\Phi_N=\log Z_N\in\Lambda$（$\Lambda=\bigoplus_p\mathbb{Z}\ell_p$）。
固有値 $\{\lambda_i\}\subset\overline{\mathbb{Q}}$（$\chi_T(x)=\det(xI-T)\in\mathbb{Z}[x]$ の根）、$Z_N=\sum_i\lambda_i^N$。
$\Phi_N$ の $\ell_p$ 係数は $v_p(Z_N)\in\mathbb{Z}_{\ge0}$。

## 命題 A（決定可能・rigorous な核。証明済み）

任意の素数 $p$、任意の切断 $k\ge1$ に対し:

1. 行列冪列 $(T^N\bmod p^k)_{N\ge1}$ は有限モノイド $M_d(\mathbb{Z}/p^k\mathbb{Z})$ 内の列だから**最終周期的**。その前周期を $N_0(p,k)$、最終周期を $\pi(p,k)$ とする。
2. ゆえに $Z_N=\mathrm{Tr}\,T^N\bmod p^k$ も最終周期的（周期 $\mid\pi(p,k)$）。
3. **切断付値** $\min(v_p(Z_N),k)$ は $Z_N\bmod p^k$ で決まるので、$N\ge N_0(p,k)$ で**周期 $\pi(p,k)$ の最終周期列**。
4. $N_0(p,k),\pi(p,k)$ および各周期内の値は、$T$ から $\mathbb{Z}/p^k$ 上で**有限手順で決定可能**（$\mathbb{R}$ 不使用）。

証明: (1) 有限モノイドの元の冪は前周期＋周期に入る（鳩の巣）。(2) トレースは環準同型 $M_d(\mathbb{Z})\to M_d(\mathbb{Z}/p^k)$ と両立。(3) $z\equiv z'\pmod{p^k}\Rightarrow\min(v_p z,k)=\min(v_p z',k)$。(4) 有限計算。∎

検証（`period_bound.sage`）: 六頂点 $(1,1,2)L2$ で $p=7,k=3$: $\pi=294$、切断付値が周期 294 で一致。$(1,1,1)L2$ 等も全 True。

## 命題 B（線形項＝Newton 多角形。SML caveat 付き）

$\mu_{\min}(p):=\min_i v_p(\lambda_i)=$ $\chi_T$ の $p$ 進 Newton 多角形の最小傾き とおくと:

- $v_p(Z_N)\ge \mu_{\min}(p)\cdot N$。
- $r_p(N):=v_p(Z_N)-\mu_{\min}(p)\,N\ge0$ は、**最小付値固有値クラスタの和 $S(N)=\sum_{i:v_p(\lambda_i)=\mu_{\min}}u_i^N$（$u_i=\lambda_i p^{-\mu_{\min}}$ は $p$ 進単位）の $v_p$** に一致する（$N$ 大、他クラスタは付値が真に大で干渉しない範囲）。
- $S(N)\bmod p^k$ は単位 $u_i$ の冪の和で周期的。ゆえに $r_p$ は**最終周期的**。ただし $S(N)$ が高位で消える **Skolem–Mahler–Lech 例外**（算術級数の有限和）でスパイクしうる。

命題 A はこの SML subtlety を「$\min(\cdot,k)$ 切断」で回避した、完全に rigorous・決定可能な版。命題 B は線形傾き $\mu_{\min}$ を Newton 多角形で与える。

## ℝ/Λ 双対（再掲・命題形）

同一の固有値集合が二つの完備化で別の量を支配:
- **$\mathbb{R}$（アルキメデス）**: 自由エネルギー密度 $-\beta f=\tfrac1L\log\lambda_{\max}$（$|\lambda|_\infty$ 最大）。
- **$\Lambda$（$p$ 進）**: $\Phi_N$ の $\ell_p$ 係数の線形傾き $\mu_{\min}(p)$（$|\lambda|_p$ 最小付値）。
詳細・未解決は root `docs/research/R-Lambda-duality/`。

## 形式検証可能性（トラック1 の眼目）

命題 A は等号・順序・周期がすべて $\mathbb{Z}/p^k$ 上の有限計算 ⇒ Lean `decide`/reflection に乗る（証明強度 RCA₀ 級）。witness = $(N_0,\pi,$ 周期内の値表$)$。これが「理論物理の数論的内容を機械検証可能に書き換える」具体例。

## 特殊素数 $p\mid q$（Potts）

`potts_phi/` の観察: 状態数 $q$ と一致する素数で $\pi(p,k)$ が増大（対称性 $S_q$ の位数）。命題 A の枠内（$\pi$ が大きいだけ）で説明される。

## 未確定（cycle 4+ / T3 連携）

- $\pi(p,k)$ の閉じた上界（$M_d(\mathbb{Z}/p^k)$ の可逆部の位数、固有値の乗法的順序から）。→ T3。
- 命題 B の SML 例外集合の明示記述。
