# cycle 18 step 2（T3 Pure）: トレース列の周期 $\pi_{\mathrm{tr}}(p,k)$（$k\ge2$）の上界

**日付**: 2026-07-31 / **track**: T3 Pure / **step**: `trace_period_bound_k_ge_2`
**数値検証**: `sagemath/check/cycle18_T3_trace_period/`

## 0. 結論（先に）

cycle 17 は「命題 C（Pisano/Wall 型上界 $\pi(p,k)\mid p^{k-1}\pi(p,1)$）はトレース列の読みでは偽
（1669 例中 56 例）」で止まっていた。本 step は**正しい上界を確定させ、証明した**。

1. **どんな $p$ 冪補正でも直らない。** $\pi_{\mathrm{tr}}(p,k)\mid p^{a}\,\pi_{\mathrm{tr}}(p,1)$ の形の主張は、
   $a$ をどう選んでも偽である（命題 12。$T=F\oplus F$, $p=2$ で $\pi_{\mathrm{tr}}(2,1)=1$,
   $\pi_{\mathrm{tr}}(2,2)=3$）。直すべきは**指数ではなく基準レベル**である。
2. **主定理（定理 7）**: 明示的に計算できる整数不変量 $w^*=w^*(T,p)\in\mathbb{N}$ が存在して
   $$\boxed{\ \pi_{\mathrm{tr}}(p,k)\ \bigm|\ p^{\,k-1}\,\pi_{\mathrm{tr}}(p,\,w^*+1)\qquad(k\ge1)\ }$$
   が成り立つ。$w^*$ は $\mathbb{Z}$ 係数 Gram 行列 $G=(\operatorname{Tr}T^{i+j})$ の
   **最大単因子の $p$ 進付値**（Smith 標準形）である。$w^*=0$ のとき（＝$p\nmid\det G$）は
   これは命題 C のトレース列版そのもの $\pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi_{\mathrm{tr}}(p,1)$ になる。
3. **なぜ壊れていたかの説明（定理 6・系 8）**: $\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$
   （補題 2）であり、$p\nmid\det G$ は「$\rho$ が $\bmod p$ で分離的」かつ「全ての重複度 $m_\lambda$ が
   $p$ で割れない」に他ならない。後者は**命題 B の条件そのもの**である。すなわち命題 C がトレース列で
   破れるのは、命題 B が「$p\mid m_\lambda$ の固有値はトレース列から見えない」と言っていることの帰結であり、
   偶然ではない。
4. **階段（定理 10）**: $k\ge 2w^*+1$ では $\pi_{\mathrm{tr}}(p,k+1)\mid p\,\pi_{\mathrm{tr}}(p,k)$。
   つまり十分上の階では 1 階につき高々 $p$ 倍しか増えない。しきい値 $2w^*+1$ を $w^*+1$ まで
   下げられるかは**数値支持のみ**（未証明。§7）。
5. **$\mathbb{R}$ へは一度も脱出しない。** 本 step の証明は $\mathbb{Z}$ 上の線形代数（Cramer / Smith 標準形）と
   $\overline{\mathbb{Q}}$ 上の Vandermonde だけで閉じており、$\mathbb{Z}_p$（非可算）すら使わない。§1 で明示する。

**新規性は主張しない。** 線形漸化列の周期・Wall の定理・トレース形式の判別式は古典であり、
本 step の内容は cycle 17 で自分たちが壊した命題の修復と、その不変量の同定である。

## 1. 設定・記号・可算性

$T\in M_d(\mathbb{Z})$、$p$ を素数、$p\nmid\det T$、$k\ge1$。

- $\pi(p,k;A)$ … 行列冪列 $(A^N\bmod p^k)_{N\ge0}$ の最小周期（$=\mathrm{GL}_d(\mathbb{Z}/p^k)$ での $A$ の位数）。
  $p\nmid\det A$ なので純周期的。
- $\pi_{\mathrm{tr}}(p,k)$ … トレース列 $(\operatorname{Tr}T^N\bmod p^k)_{N\ge0}$ の最小周期。
- $\chi=\chi_T=\prod_{i=1}^s f_i^{a_i}$（$f_i\in\mathbb{Z}[x]$ は相異なるモニック既約。Gauss の補題）。
  $\rho=\prod_i f_i$（$\chi$ の根基）、$r=\deg\rho$。
- $S=\bigoplus_i C_{f_i}^{\oplus a_i}\in M_d(\mathbb{Z})$（$C_f$ は $f$ の同伴行列）。
- $G=\bigl(\operatorname{Tr}T^{i+j}\bigr)_{0\le i,j<r}\in M_r(\mathbb{Z})$、$\Delta=\det G$、
  $v=v_p(\Delta)$、$w^*=v_p(e_r)$（$e_r$ は $G$ の最大単因子＝Smith 標準形の最後の対角成分）。
  常に $w^*\le v$。

**可算性の明示**: 登場する対象は $\mathbb{Z}$ の元、$\mathbb{Z}$ 係数行列、$\overline{\mathbb{Q}}$ の代数的数、
有限環 $\mathbb{Z}/p^k$ の元だけである。$\mathbb{R}$・$\mathbb{C}$・$\mathbb{Z}_p$・$\mathbb{Q}_p$ は**使わない**
（$\mathbb{Z}_p$ は非可算なので、使えば「脱出」として明示する必要があるが、本 step の証明は
$\mathbb{Z}$ 上の Cramer 則と Smith 標準形で閉じるため不要だった）。
$w^*$・$v$ はいずれも整数行列の Smith 標準形・行列式から**有限手続きで決定可能**であり、
$\pi_{\mathrm{tr}}(p,k)$ 自身も有限環 $M_d(\mathbb{Z}/p^k)$ 上の探索で決定可能である。

## 2. トレース列は $\chi_T$ だけで決まる

**補題 1.** $\operatorname{Tr}T^N$（$N\ge0$）は $\chi_T$ の係数から Newton の公式で定まる整数であり、
$T$ 自身には依らない。とくに $\operatorname{Tr}S^N=\operatorname{Tr}T^N$（$\forall N$）、$\det S=\det T$、
$\chi_S=\chi_T$、$\mathrm{minpoly}(S)=\rho$。したがって
$$\pi_{\mathrm{tr}}(p,k;T)=\pi_{\mathrm{tr}}(p,k;S).$$

*証明.* $\operatorname{Tr}T^N=\sum_\lambda m_\lambda\lambda^N$ は $\chi_T$ の根の $N$ 次冪和で、
Newton の公式により $\chi_T$ の係数の $\mathbb{Z}$ 多項式である。$S$ は構成から $\chi_S=\chi_T$ を満たす
（同伴行列の特性多項式は $f_i$）。$\mathrm{minpoly}(S)=\mathrm{lcm}_i f_i=\rho$。∎

以後、行列冪列側の主張はすべて **$S$ について**述べる（$T$ が半単純でない場合、
$\pi(p,k;T)$ はトレース列から原理的に見えない。§7 の例）。

## 3. Gram 行列と不変量

**補題 2.** $\Delta=\det G=\operatorname{disc}(\rho)\cdot\prod_{\lambda}m_\lambda\neq0$。
ここで $\lambda$ は $\chi$ の $\overline{\mathbb{Q}}$ における相異なる根（$r$ 個）を走り、$m_\lambda$ はその重複度。

*証明.* $G_{ij}=\operatorname{Tr}T^{i+j}=\sum_\lambda m_\lambda\lambda^{i+j}$ なので、
$V=(\lambda^i)_{0\le i<r,\ \lambda}$（$r\times r$ Vandermonde）とおくと $G=V\,\mathrm{diag}(m_\lambda)\,V^{\mathsf T}$。
よって $\Delta=(\det V)^2\prod_\lambda m_\lambda=\operatorname{disc}(\rho)\prod_\lambda m_\lambda$。
$\rho$ は標数 $0$ 上で分離的だから $\operatorname{disc}(\rho)\neq0$、また $m_\lambda\ge1$ なので $\Delta\neq0$。∎

**系.** $v=v_p(\Delta)=v_p(\operatorname{disc}\rho)+\sum_\lambda v_p(m_\lambda)$。とくに
$$v=0\iff w^*=0\iff \text{$\rho\bmod p$ が分離的、かつ全ての $\lambda$ で $p\nmid m_\lambda$}.$$
右側の後半は**命題 B の条件そのもの**である。

## 4. 主定理

**命題 3.** $\pi_{\mathrm{tr}}(p,k)\mid\pi(p,k;S)$、$\pi_{\mathrm{tr}}(p,k)\mid\pi(p,k;T)$。
*証明.* 行列冪列の周期はトレース列の周期でもあり、最小周期は任意の周期を割る。∎

**命題 4.** $\pi_{\mathrm{tr}}(p,k)\mid\pi_{\mathrm{tr}}(p,k+1)$。
*証明.* $\bmod p^{k+1}$ の周期は $\bmod p^k$ の周期。∎

**命題 5（行列冪列版 Wall 型上界。既知）.** $\pi(p,k;A)\mid p^{k-1}\pi(p,1;A)$。
*証明.* $X\equiv I\ (p^j)$、$j\ge1$ なら $X=I+p^jA$ で
$X^p=I+p^{j+1}A+\sum_{i\ge2}\binom{p}{i}p^{ij}A^i$。$2\le i\le p-1$ では $v_p\ge1+ij\ge j+2$、
$i=p$ では $v_p\ge pj\ge j+1$。よって $X^p\equiv I\ (p^{j+1})$（$p=2$ でも成立）。∎

**定理 6（本 step の核）.** $t=\pi_{\mathrm{tr}}(p,k)$ とおく。$k>w^*$ なら
$$\text{(i)}\ \ \pi(p,k-w^*;S)\mid t,\qquad \text{(ii)}\ \ \pi(p,k;S)\mid p^{w^*}\,t .$$

*証明.* $R=\mathbb{Z}[S]$ は $\mathrm{minpoly}(S)=\rho$ がモニックなので $I,S,\dots,S^{r-1}$ を
$\mathbb{Z}$ 基底とする階数 $r$ の自由 $\mathbb{Z}$ 加群である。
$B=S^{t}-I\in R$ と書き、$B=\sum_{j<r}b_jS^j$（$b_j\in\mathbb{Z}$）とする。
$t$ はトレース列の周期だから、補題 1 より全ての $N\ge0$ で
$$\operatorname{Tr}(S^NB)=\operatorname{Tr}T^{N+t}-\operatorname{Tr}T^{N}\equiv0\pmod{p^k}.$$
$N=0,\dots,r-1$ を取れば、これは $\mathbb{Z}^r$ のベクトル $b=(b_j)$ について
$Gb\equiv0\pmod{p^k}$ を意味する。$G$ の Smith 標準形を $G=U\,\mathrm{diag}(e_1,\dots,e_r)\,W$
（$U,W\in\mathrm{GL}_r(\mathbb{Z})$、$e_1\mid\cdots\mid e_r$）とすると、$p^{w^*}G^{-1}$ は
$p$ 進整数成分をもつ（$w^*=v_p(e_r)$）ので、$b=G^{-1}(Gb)$ から
$p^{k-w^*}\mid b_j$（$\forall j$）を得る。すなわち $B\equiv0\pmod{p^{k-w^*}}$、
つまり $S^{t}\equiv I\pmod{p^{k-w^*}}$。これが (i)。
(ii) は (i) と命題 5 を $w^*$ 回:
$\pi(p,k;S)\mid p^{w^*}\pi(p,k-w^*;S)\mid p^{w^*}t$。∎

> 注: $\det G$ による Cramer 則でも $p^{k-v}\mid b_j$ が出る（$v=v_p(\Delta)$）が、
> Smith 標準形を使うと $v$ を最大単因子 $w^*\le v$ に置き換えられる。この差は実際に効く
> （$T=F\oplus F$, $p=2$ では $v=2$ に対し $w^*=1$。§6 の named 表）。

**定理 7（主結果）.** すべての $k\ge1$ で
$$\pi_{\mathrm{tr}}(p,k)\ \bigm|\ p^{\,k-1}\,\pi_{\mathrm{tr}}(p,\,w^*+1).$$

*証明.* $k\le w^*+1$ なら命題 4 より $\pi_{\mathrm{tr}}(p,k)\mid\pi_{\mathrm{tr}}(p,w^*+1)$。
$k>w^*+1$ なら、定理 6(i) を $k=w^*+1$ に適用して $\pi(p,1;S)\mid\pi_{\mathrm{tr}}(p,w^*+1)$。
よって命題 3・命題 5 から
$$\pi_{\mathrm{tr}}(p,k)\mid\pi(p,k;S)\mid p^{k-1}\pi(p,1;S)\mid p^{k-1}\pi_{\mathrm{tr}}(p,w^*+1).\qquad\blacksquare$$

**系 8（命題 C のトレース列版が成り立つ場合の完全な特徴づけの十分条件）.**
$p\nmid\det G$（$\iff w^*=0$）なら、すべての $k\ge1$ で
$$\pi_{\mathrm{tr}}(p,k)=\pi(p,k;S),\qquad \pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi_{\mathrm{tr}}(p,1).$$
*証明.* $w^*=0$ で定理 6(i) は $\pi(p,k;S)\mid\pi_{\mathrm{tr}}(p,k)$、命題 3 が逆向き。定理 7 で $w^*=0$。∎

**系 9（$p,d,k$ だけによる明示上界）.**
$$\pi_{\mathrm{tr}}(p,k)\ \bigm|\ p^{\,k-1+\lceil\log_p d\rceil}\cdot\operatorname{lcm}_{1\le i\le d}(p^i-1).$$
*証明.* 命題 3・命題 5 より $\pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi(p,1;S)$。
$S\bmod p$ の乗法的 Jordan 分解で、半単純部分の位数は各固有値 $\mu\in\mathbb{F}_{p^i}^\times$（$i\le d$）の
位数の lcm を割り、冪単部分の位数は $p^{\lceil\log_p(\text{最大 Jordan ブロック})\rceil}\mid p^{\lceil\log_p d\rceil}$。∎

**定理 10（階段）.** $k\ge 2w^*+1$ なら $\pi_{\mathrm{tr}}(p,k+1)\mid p\,\pi_{\mathrm{tr}}(p,k)$。

*証明.* $t=\pi_{\mathrm{tr}}(p,k)$、$B=S^t-I$ とおく。定理 6 の証明より $B\equiv0\ (p^{k-w^*})$。
$$S^{pt}-I=(I+B)^p-I=pB+\sum_{i=2}^{p-1}\binom{p}{i}B^i+B^p .$$
任意の $N$ で $\operatorname{Tr}(S^NB)\equiv0\ (p^k)$ だから $\operatorname{Tr}(S^N\cdot pB)\equiv0\ (p^{k+1})$。
$2\le i\le p-1$ の項は $v_p\ge1+i(k-w^*)\ge1+2(k-w^*)\ge k+1$（$k\ge2w^*$）、
$i=p$ の項は $v_p\ge p(k-w^*)\ge2(k-w^*)\ge k+1$（$k\ge2w^*+1$）。
よって $\operatorname{Tr}(S^N(S^{pt}-I))\equiv0\ (p^{k+1})$ が全 $N$ で成り立ち、$pt$ は
$\bmod p^{k+1}$ の周期。最小周期はこれを割る。∎

**系 11（非 $p$ 因子は下の階でしか増えない）.** $k>w^*$ では
$\pi_{\mathrm{tr}}(p,k)=p^{e_k}\,\pi(p,1;S)$（$e_k\in\mathbb{N}$ 単調非減少）。
とくに $k>w^*$ の範囲では $\pi_{\mathrm{tr}}(p,k+1)/\pi_{\mathrm{tr}}(p,k)$ は $p$ 冪である。
*証明.* 定理 6(i) より $\pi(p,1;S)\mid\pi_{\mathrm{tr}}(p,k)$、命題 3・命題 5 より
$\pi_{\mathrm{tr}}(p,k)\mid\pi(p,k;S)\mid p^{k-1}\pi(p,1;S)$。∎

これが cycle 17 の反例の構造的説明である: 反例では $\pi_{\mathrm{tr}}(p,1)=1$ なのに
$\pi_{\mathrm{tr}}(p,2)$ が $3$ や $6$ という**$p$ と互いに素な因子**を含んでいた。系 11 は
そのような跳躍が $k\le w^*$ の階でしか起きないことを言う。

## 5. どんな $p$ 冪補正でも直らないこと

**命題 12.** $\pi_{\mathrm{tr}}(p,k)\mid p^{a}\pi_{\mathrm{tr}}(p,1)$ の形の主張は、$a$ を $k,d,p$ の
どんな関数に取っても偽である。

*証明.* $F=\begin{pmatrix}0&1\\1&1\end{pmatrix}$、$T=F\oplus F$、$p=2$ とする（$\det T=1$ なので
$p\nmid\det T$）。$\operatorname{Tr}T^N=2L_N$（$L_N$ は Lucas 数）。
$\bmod2$ では恒等的に $0$ なので $\pi_{\mathrm{tr}}(2,1)=1$。
$\bmod4$ では $2L_N\bmod4$ は $L_N\bmod2$ で決まり、$L_N\bmod2=(0,1,1,0,1,1,\dots)$ は
最小周期 $3$（$L_0=2$ は偶、$L_1=1$ は奇なので周期 $1$ ではない）。よって $\pi_{\mathrm{tr}}(2,2)=3$。
$3\nmid2^a$（$\forall a$）。∎

この例で $w^*=1$ であり、定理 7 は $\pi_{\mathrm{tr}}(2,k)\mid2^{k-1}\pi_{\mathrm{tr}}(2,2)=2^{k-1}\cdot3$ を主張する。
実測 $\pi_{\mathrm{tr}}(2,k)=1,3,6,12,24,48$（$k=1..6$）はこれをちょうど満たす（§6 の tight 例）。

## 6. 数値検証

コード: `sagemath/check/cycle18_T3_trace_period/trace_period_bounds.sage`（SageMath 10.6、seed 固定で再現可能）。
ログ: 同ディレクトリ `trace_period_bounds.out`。標本は
**random 385 組** + **degenerate-enriched 506 組**（$\chi\bmod p$ が非分離になりやすい
$A\oplus A$・$A\oplus A\oplus B$・非半単純摂動）、$k=1..6$。

### 6.1 cycle 17 の反例と対照例

| $T$ | $p$ | $\det G$ | $v$ | $w^*$ | $\pi_{\mathrm{tr}}(p,k),\ k=1..6$ | 素朴上界 $p^{k-1}t_1$ | 主結果 $p^{k-1}t_{w^*+1}$ |
|---|---|---|---|---|---|---|---|
| $F\oplus F$ | 2 | 20 | 2 | 1 | 1, 3, 6, 12, 24, 48 | $k\ge2$ で**破れる** | 全 $k$ で成立 |
| $\begin{psmallmatrix}1&1&-1\\2&1&-2\\-2&-1&-1\end{psmallmatrix}$ | 2 | 788 | 2 | 1 | 1, 4, 8, 16, 32, 64 | $k\ge2$ で**破れる** | 全 $k$ で成立 |
| $\begin{psmallmatrix}2&-1&2\\-3&-3&-2\\-1&-2&-2\end{psmallmatrix}$ | 3 | 6669 | 3 | 1 | 1, 6, 18, 54, 162, 486 | $k\ge2$ で**破れる** | 全 $k$ で成立 |
| $\begin{psmallmatrix}-3&-2&-1\\3&-3&-2\\2&2&-1\end{psmallmatrix}$ | 2 | −6028 | 2 | 1 | 1, 4, 8, 16, 32, 64 | $k\ge2$ で**破れる** | 全 $k$ で成立 |
| $F$ | 2 | 5 | 0 | 0 | 3, 6, 12, 24, 48, 96 | 成立 | 成立（同じ主張） |
| $F$ | 5 | 5 | 1 | 1 | 4, 20, 100, 500, … | 成立 | 成立 |
| $\begin{psmallmatrix}1&1\\0&1\end{psmallmatrix}$ | 2 | 2 | 1 | 1 | 1, 1, 1, 1, 1, 1 | 成立 | 成立 |

$v$ と $w^*$ の差が実際に効いている（4 例すべてで $w^*<v$）。とくに $p=3$ の例では $v=3$ だが $w^*=1$ で、
定理 7 の基準レベルは $k=4$ ではなく $k=2$ で済む。

補題 2 の等式 $\det G=\operatorname{disc}(\rho)\prod_\lambda m_\lambda$ は **891 組すべてで一致**（反例 0）。

### 6.2 仮説ごとの検査結果（全 891 組の合算）

「非自明」は、その仮説が自明に成り立つ場合（例: $t_k=\pi(p,k)$ で等号のとき）を除いた件数。
定義していない仮説は 0 と表示される。

| 仮説 | 内容 | 検査 | 非自明 | 反例 |
|---|---|---:|---:|---:|
| L | $\det G=\operatorname{disc}(\rho)\prod m_\lambda$（補題 2） | 891 | 891 | **0** |
| B0/B1 | $t_k\mid\pi(p,k;T)$, $t_k\mid\pi(p,k;S)$（命題 3） | 5346/5346 | 2120/1061 | **0** |
| B2 | $t_k\mid t_{k+1}$（命題 4） | 4455 | 3616 | **0** |
| B3 | $\pi(p,k;S)\mid p^{k-1}\pi(p,1;S)$（命題 5） | 5346 | — | **0** |
| B4 | $k>w^*\Rightarrow\pi(p,k-w^*;S)\mid t_k$（定理 6(i)） | 4829 | 1343 | **0** |
| B5 | $k>w^*\Rightarrow\pi(p,k;S)\mid p^{w^*}t_k$（定理 6(ii)） | 4829 | 776 | **0** |
| **B6** | **$t_k\mid p^{k-1}t_{w^*+1}$（定理 7・主結果）** | **5328** | **210** | **0** |
| B6d | $t_k\mid p^{k-1}t_{v+1}$（$v$ 版の粗い形） | 5256 | 210 | **0** |
| B7 | $w^*=0\Rightarrow t_k=\pi(p,k;S)$（系 8） | 3486 | — | **0** |
| B8 | $t_k\mid p^{k-1+\lceil\log_pd\rceil}\mathrm{lcm}_i(p^i-1)$（系 9） | 5346 | — | **0** |
| X3p | $k\ge2w^*+1\Rightarrow t_{k+1}\mid p\,t_k$（定理 10） | 3539 | 3539 | **0** |
| X1 | $t_k\mid p^{k-1}t_1$（**素朴な持ち上げ**） | 5346 | — | **210（3.9%）** |
| X2 | $t_{k+1}\mid p\,t_k$（**素朴な階段**） | 4455 | — | **70（1.6%）** |
| X2low | $k\le w^*$ に限った $t_{k+1}\mid p\,t_k$ | 514 | 514 | **70（13.6%）** |
| X4 | $t_k\mid p^{k-1}t_{w^*}$（基準レベルを 1 下げる） | 1842 | 1842 | **200（10.9%）** |
| X3g | $w^*+1\le k\le 2w^*\Rightarrow t_{k+1}\mid p\,t_k$（**未証明**） | 402 | 402 | **0** |

- **証明済みの主張（L, B0–B8, X3p）は反例 0**。証明とコードが独立に整合している。
- X1 の破れ 3.9% は cycle 17 の 3.4% と整合する（標本が違うので一致はしない）。
- **X4 の反例 200 件は、定理 7 の基準レベル $w^*+1$ を $w^*$ へ下げられないことを示す**（＝主結果の
  基準レベルはこの不変量に関しては最良）。
- 指数 $k-1$ の sharpness: $t_k\mid p^{m}t_{w^*+1}$ を満たす最小 $m$ について
  余裕 $(k-1)-m$ の分布は $\{0:2955,\ 1:807,\ 2:530,\ 3:257,\ 4:167,\ 5:113\}$。
  **2955 件で $m=k-1$ ちょうど**なので、指数 $k-1$ も一般には下げられない。
- $w^*$ の必要性の別角度: $w=\min\{j:\pi(p,1;S)\mid t_{j+1}\}$ とすると
  $w^*-w$ の分布は $\{0:731,1:73,2:54,3:17,4:9,5:5,6:2\}$。
  **82% の標本で $w^*$ はちょうど最小レベル**（定理 6(i) が等号で効いている）。

## 7. 数値支持どまり・未解決

### 7.1 数値支持どまり（証明していない）

**予想 A.** $k\ge w^*+1$ なら $\pi_{\mathrm{tr}}(p,k+1)\mid p\,\pi_{\mathrm{tr}}(p,k)$。

定理 10 が証明しているのは $k\ge2w^*+1$ の範囲である。隙間 $w^*+1\le k\le2w^*$ は
**402 件の検査で反例 0** だが、**証明していない**。

**偶然 0 件になる可能性の見積もり（0 件を根拠にしないための規律）**:
同じ divisibility を「本当に破れる領域」$k\le w^*$ で測ると破れ率は $70/514=13.6\%$ である。
仮に隙間でも同率で破れるなら、402 件で 0 件になる確率は $(1-0.136)^{402}\approx4\times10^{-26}$ で、
偶然では説明できない。ただし**隙間の破れ率が $k\le w^*$ と同じである保証はない**。
402 件の検査で 95% の確率で検出できるのは破れ率 $\ge0.74\%$ の場合までであり
（$1-(1-q)^{402}\ge0.95\iff q\ge0.0074$）、**それ未満の稀な反例は本標本では原理的に検出できない**。
また 402 件は $w^*\ge1$ の高々 310 個の行列に由来し（1 行列が $k$ を変えて最大 5 件寄与）、
検査は独立ではない。したがって予想 A は**数値支持どまり**と明記する。

### 7.2 未解決

- **$\pi_{\mathrm{tr}}(p,k)$ の閉じた公式**（命題 B の $k\ge2$ 版）は依然として無い。本 step が与えたのは
  上界と、$k>w^*$ での構造 $\pi_{\mathrm{tr}}(p,k)=p^{e_k}\pi(p,1;S)$（系 11）だけで、
  指数列 $(e_k)$ を固有値データから決める式は無い。
- **$w^*$ を Newton 多角形・分岐データで書けるか**。$\det G=\operatorname{disc}(\rho)\prod m_\lambda$ の
  $p$ 進付値は分かるが、**最大単因子**の付値 $w^*$ を代数的不変量で表す式は得ていない
  （Smith 標準形を計算すれば決まるので決定可能性には影響しない）。
- **$T$ が半単純でない場合、$\pi(p,k;T)$ はトレース列から復元できない。**
  $T=\begin{psmallmatrix}1&1\\0&1\end{psmallmatrix}$, $p=2$ では $\pi_{\mathrm{tr}}(2,k)=1$（全 $k$）に対し
  $\pi(2,k;T)=2^k$。本 step の定理はすべて半単純模型 $S$ について述べており、
  この意味で「トレース列から行列冪列の周期を回復する」ことは一般には不可能である（§6.1 最終行）。
- Lean 化は未着手（cycle 18 step 3 が命題 N・T・W を扱うので、そこには含めていない）。

## 8. 自分の誤り（隠さず記録する）

本 step の最初の導出で、次の 2 つの誤りを犯した。いずれも数値検証の 1 回目で露見した。

1. **$\pi_{\mathrm{tr}}(p,k)\mid p^{k-1+v}\pi_{\mathrm{tr}}(p,1)$ を主結果として立てた。これは偽である。**
   $\pi(p,k;S)\mid p^{v}\pi_{\mathrm{tr}}(p,k)$ を $k=1$ でも使えると思い込んだが、
   定理 6 は $k>w^*$（当時は $k>v$）でしか成り立たない。$T=F\oplus F$, $p=2$ で
   $\pi_{\mathrm{tr}}(2,2)=3\nmid2^{1+2}=8$ と即座に反証された。§5 の命題 12 は、
   この失敗を一般化して「$p$ 冪補正はどう取っても不可能」という形の主張に変えたものである。
2. **Gram 行列の非退化性を、$T$ の最小多項式が分離的でない場合にも成り立つと仮定していた。**
   $T=\begin{psmallmatrix}1&1\\0&1\end{psmallmatrix}$ で $\det G=0$ となり実行時エラーで露見した。
   $\chi$ の**根基** $\rho$ を取り、半単純模型 $S$ へ移す（補題 1）ことで解消した。

いずれも「証明を数値で確かめる」手順を先に回したから見つかった。逆に言えば、
**最初の版を数値検証なしに報告していたら、cycle 17 と同型の事故（偽の命題を確定として記録する）を
繰り返していた。**

## 9. 論文本文への反映

`structured-latex/content/004_lambda_finite.ts` に **命題 C′（ラベル `paper_prop_C_trace`）** を追加した。

- 命題 C 側の「したがって $\pi_{\mathrm{tr}}(p,k)$（$k\ge2$）の上界は**未確立**である」という文を、
  命題 C′ への参照へ差し替えた（未確立ではなくなったため）。
- 命題 C′ には定理 7（主結果）・補題 2（$\det G$ の公式）・命題 12（$p$ 冪補正の不可能性）・
  決定可能性を載せ、証明を付けた。`verification` は `sagemath/check/cycle18_T3_trace_period`。
- 予想 A（隙間の階段）は**数値支持どまりなので本文には入れていない**。本報告の §7.1 だけに置く。

