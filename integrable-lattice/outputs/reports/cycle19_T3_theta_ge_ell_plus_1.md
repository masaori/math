# cycle 19 / T3 Pure: 消滅深度 $\theta\ge\ell+1$ の領域 — 桁定理・ファイバー Newton 公式・閉形式

対象: cycle 18（`outputs/reports/cycle18_T3_general_degenerate_tower.md`）§6.1 が
**「予想ではなく、次に試すべき具体的な手順である」**と明記して残した計算をやる。
すなわち、消滅深度 $\theta_M(a,b)=\min\{m:\ell\nmid A_m(a,b)\}$ を $a,b$ の $\ell$ 進展開の
**桁ごと**に記述する式を作り（補題 A3 の Lucas 評価を第 2 桁・第 3 桁へ延長し）、
$\theta\ge\ell+1$ の退化塔で閉形式が出るかを確かめる。

前提として読んでいる一次情報:
`cycle18_T3_general_degenerate_tower.md`（補題 A1–A5、定理 B、定理 C、命題 F・G、§4.3–§4.5、§6.1）、
`cycle17_T3_degenerate_torus_odd_ell.md`（§6.1）、
`cycle16_T3_lower_order_and_degeneracy.md`（定理 N1、定理 D1・D2、補題 5.5、§7 の型分類）、
`cycle14_T3_two_variable_criterion.md`（式 $(1.1)$、補題 5.2、補題 8.4）。

**記号の約束**: cycle 18 に従い、消滅深度は $\theta$ と書く（論文本文 `paper_prop_G` の (G1′) の
「ずれ指数 $\delta$」とは別物である）。本 report で新たに導入する命題には $J$ を冠する。

---

## 0. 結論（先に置く）

| 主張 | 状態 |
|---|---|
| **補題 J0**: $\bar A_m$ は $(a,b)$ に $\ell$ 進連続に依存し、$\theta$ は $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数へ延びる | **証明した**（§2.1） |
| **定理 J2（桁定理）**: $0\le m\le\ell^L$ なら $\bar A_m$ は $(a,b)\bmod\ell^L$ だけの関数。cycle 18 補題 A3 は $L=1$ の場合 | **証明した**（§2.2）。**これが「Lucas を第 2 桁・第 3 桁へ延長する」の答えである** |
| **命題 J2′（閾値の鋭さ）**: $m=\ell^L+1$ での破れは $\bar A_2$ の極形式 $\bar B$ で与えられ、$L$ に依らない。$\ell$ 奇なら「破れる $\iff k=2$」、$\ell=2$ なら「破れる $\iff\bar A_2$ が平方でない」 | **証明した**（§2.3）。cycle 18 命題 G が「起きうる」としか言えなかった箇所が**必要十分**になった |
| **系 J3**: $\theta$ が有限な点では局所定数。$\mathbb{P}^1(\mathbb{Z}_\ell)$ 上で至る所有限なら $\theta$ は有界で、ある $\mathbb{P}^1(\mathbb{Z}/\ell^L)$ を経由する | **証明した**（§2.4）。コンパクト性を使う |
| **定理 J4（ファイバー Newton 公式）**: 基点 $P_0$ を取ったファイバーで $\theta\ge\Lambda(r)=\min_j(e_j+j\ell^r)$、$r=1+v_\ell(\beta)$。$\mathrm{argmin}$ が一意なら等号。等号の破れは $\sum_{j\in J(r)}\lambda_j\beta_v^{\,j}=0$ ちょうど | **証明した**（§3.2）。**$\theta$ の $M$ 依存の正体は $\mathbb{G}_m$ の $\ell$ 冪 Frobenius に関する Newton 多角形である** |
| **系 J5（判定条件）**: $e_0<\infty$ かつ $\forall j\ge1: e_j+j\ell>e_0$ なら $\theta\equiv e_0$（ファイバー上定数）。これは $\theta(P_0)\le\ell$ を**真に含む**有限判定条件 | **証明した**（§3.3）。真に広いことは実例で確認（§8.2） |
| **補題 J1（レベル分解）**: $\Sigma_n=\sum_{M'=1}^n\Theta_{M'}$、$\Theta_{M'}=\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^{M'})}\hat\theta_{M'}(P)$（$\varphi$ が完全に相殺する） | **証明した**（§4.1）。仮定なしで成り立つ |
| **定理 B′（2 付値 Newton 多角形）**: $\hat\theta_M(a,b)=\min_m\bigl(\varphi(\ell^M)v_\ell(A_m)+m\bigr)$（最小点が一意なとき）。cycle 18 定理 B はその特別な場合 | **証明した**（§4.2） |
| **定理 K（一般の予言アルゴリズム）**: 上の 2 つを合わせると、$\mathrm{ord}_\ell(\kappa_n)$ は $D$ の係数だけからの有限計算で決まる（塔の値も円分体の計算も使わない） | **証明した**（§4.3）。母集団全走査で塔の値と照合（§8.1） |
| **定理 J6（$\theta$ 有限 ⇒ 型 II の閉形式）**: $\theta$ が至る所有限なら閉形式は $\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+\frac{\Theta_L}{\varphi(\ell^L)}\ell^n-2n+\nu$。**$n\ell^n$ 項は出ない** | **証明した**（§5.1）。cycle 18 定理 C は $L=1$ の場合 |
| **cycle 18 §4.4 の観察の格上げ** | **証明した**（§6）。cycle 18 が「数値支持どまり」と明記した $\ell=3$, $(1,0),(0,1),(1,1)$ の一定性は、系 J5 の判定条件から**証明**される。閉形式 $\mathrm{ord}_3(\kappa_n)=5(3^n-1)-2n$ も**全ての $n\ge0$ で証明された** |
| **定理 J7（$\theta=\infty$ ⇒ 型 III）**: $n\ell^n$ 項の係数は $b=\sum_{P\in S_\infty}j^*(P)$、$S_\infty=\{P\in\mathbb{P}^1(\mathbb{Z}_\ell):\theta(P)=\infty\}$ | **証明した**（§5.2、仮定つき）。**和は $\mathbb{P}^1(\mathbb{F}_\ell)$ の方向ではなく $\mathbb{P}^1(\mathbb{Z}_\ell)$ の点についてである**（ここを取り違えたのが本サイクル最大の誤り。§11.2） |
| **定理 J8（型 III 塔の族と閉形式）**: $\ell$ 奇素数、bouquet に $(1,0)$ を $\ell-1$ 本・$(0,1)$ を 1 本置くと、**全ての $n\ge0$** で $\mathrm{ord}_\ell(\kappa_n)=2n\ell^n+2\ell^n-2$。この族では $S_\infty=\{(1{:}1),(1{:}-1)\}$ が**厳密に決定できる** | **証明した**（§5.3）。cycle 16 が持っていた型 III の実例は $\ell=2$ トーラス 1 個だけだった。**奇素数の型 III 塔の無限族と、その閉形式が初めて出た** |
| $\ell=2$ トーラスでは $b$ は当たるが定理 J7 の仮定は破れている | **確定した**（§5.4）。$S_\infty$ の 2 点が $\bmod\ 2$ で分離されないため打ち消しが起き、$\Theta_{M'}$ の定数項が出ない（真値 $\Theta_3=44$ に対し定理 B′ の和は $40$）。cycle 16 が $\ell=2$ トーラスを特別扱いした理由の説明になっている |
| 残る障害（打ち消し $J(r)$ 非一意、$S_\infty$ が有限か、$S_\infty$ を決める手続き） | **未解決**（§7）。何が足りないかを具体化し、打ち消しの実例は奇 $\ell$ でも示した |
| 新規性 | **主張しない**（§10） |

**「証明した」と書いたものは、すべて有限個の例に依らない証明が本文にある。
数値支持どまりのものは §9 に隔離し、標本サイズから何が言えるかを明記した。**

---

## 1. 設定

記号は cycle 18 §1 をそのまま引き継ぐ。$X$ は有限連結 voltage 多重グラフ、$\alpha:E\to\mathbb{Z}^2$、
$L(z,w)$ は voltage ラプラシアン、$D=\det L\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$、
$\mu=v_\ell(\mathrm{content}_{z,w}D)$、$E=\ell^{-\mu}D$、$g(T,S)=E(1+T,1+S)$、$k=\mathrm{ord}(\bar g)$、
$H$ は $\bar g$ の最低次斉次部分、$Z_H$ はその $\mathbb{P}^1(\mathbb{F}_\ell)$ 有理零点、$z_H=|Z_H|$、
$\kappa_n=\kappa(X_{\ell^n,\ell^n})$。仮定 **(H)** を通して置く。

$\tilde E=z^rw^sE=\sum_{(p,q)}c_{pq}z^pw^q\in\mathbb{Z}[z,w]$（$p,q\ge0$）とし、cycle 18 補題 A1・A5 の

$$\Phi_{(a,b)}(x):=\tilde E\bigl((1+x)^a,(1+x)^b\bigr)=\sum_{m\ge0}A_m(a,b)\,x^m\in\mathbb{Z}[x],\qquad
A_m(a,b)=\sum_{(p,q)}c_{pq}\binom{pa+qb}{m} \tag{1.1}$$

を出発点にする。$\theta(a,b)=\mathrm{ord}_{x=0}\overline{\Phi_{(a,b)}}\in\mathbb{N}\cup\{\infty\}$（$\overline{\phantom{x}}$ は $\bmod\ \ell$）。
cycle 14 $(6.1)$ より

$$\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa(X))-2n+\mu(\ell^{2n}-1)+\Sigma_n,\qquad
\Sigma_n=\sum_{\substack{\zeta^{\ell^n}=\xi^{\ell^n}=1\\(\zeta,\xi)\neq(1,1)}}v_\ell\bigl(E(\zeta,\xi)\bigr). \tag{1.2}$$

$M\ge1$、$g$ を原始 $\ell^M$ 乗根、$\pi=g-1$、$v_\ell(\pi)=\alpha=1/\varphi(\ell^M)$。

**測る量の定義（本 report を通して使う）**: レベルちょうど $M'$ の点 $(\zeta,\xi)$ に対して

$$\hat\theta_{M'}(\zeta,\xi):=\varphi(\ell^{M'})\cdot v_\ell\bigl(E(\zeta,\xi)\bigr)\in\mathbb{Q}_{\ge0}. \tag{1.3}$$

$\theta$（$\bmod\ \ell$ の消滅位数、$D$ の係数から決まる量）と $\hat\theta$（実際の付値、幾何的な量）を
**厳密に区別する**。両者が一致するのは定理 B / 定理 B′ の条件下だけであり、
cycle 18 §4.3 の表が測っていたのは $\hat\theta$ の方である。

---

## 2. 桁定理（Lucas を第 2 桁・第 3 桁へ延長する）

### 2.1 補題 J0（$\theta$ は $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数である）

> **補題 J0.** *$m$ を固定し $\ell^L>m$ とすると、$\binom{N}{m}\bmod\ell$ は $N\bmod\ell^L$ だけの関数である。
> したがって $\bar A_m(a,b)$ は $(a,b)\bmod\ell^L$ だけの関数であり、$(a,b)\mapsto\overline{\Phi_{(a,b)}}$ は
> $\mathbb{Z}_\ell^2$ 上の（局所定数な）写像へ一意に延びる。さらに $\theta(ca,cb)=\theta(a,b)$（$c\in\mathbb{Z}_\ell^\times$）
> なので、$\theta$ は $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の $\mathbb{N}\cup\{\infty\}$ 値関数を定める。*

**証明.** Lucas の定理より $\binom Nm\equiv\prod_{i\ge0}\binom{N_i}{m_i}$。$\ell^L>m$ なら $m_i=0$（$i\ge L$）で
$\binom{N_i}{0}=1$ だから、右辺は $N_0,\dots,N_{L-1}$ すなわち $N\bmod\ell^L$ だけで決まる。
$N=pa+qb$ は $(a,b)\bmod\ell^L$ で決まるので $\bar A_m$ も同様。$m$ ごとに $L$ を取り替えれば
各 $\bar A_m$ が $\mathbb{Z}_\ell^2$ 上の局所定数関数へ延び、$\overline{\Phi}$ の係数列全体が延びる。

scale 不変性は cycle 18 補題 A4 の証明がそのまま通る:
$\rho(x)=(1+x)^c-1\in\mathbb{Z}_\ell[[x]]$ は $\bar\rho=cx+\cdots$ で $x=0$ での位数ちょうど 1、
$\Phi_{(ca,cb)}=\Phi_{(a,b)}\circ\rho$ なので合成の位数は $\theta(a,b)$ に等しい。$\blacksquare$

**注 2.1.** $\theta$ の定義域が $\mathbb{P}^1(\mathbb{F}_\ell)$（$\ell+1$ 点）ではなく
**$\mathbb{P}^1(\mathbb{Z}_\ell)$（コンパクトな非可算集合だが、有限レベルの逆極限として完全に可算な記述をもつ）**
だと認めることが、本サイクルの視点の変更である。cycle 18 は $\theta$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上の関数に
なる条件（$\theta\le\ell$）を求めていたが、**なる必要はなく、$\mathbb{P}^1(\mathbb{Z}_\ell)$ 上で扱えばよい。**

**注 2.2（可算性）.** $\mathbb{P}^1(\mathbb{Z}_\ell)$ は非可算だが、本 report で $\theta$ について述べる主張は
すべて有限レベル $\mathbb{P}^1(\mathbb{Z}/\ell^L)$（有限集合）への還元を経由する。
$\mathbb{R}$ は一度も使わない（§4.4 で改めて確認する）。

### 2.2 定理 J2（桁定理）

> **定理 J2.** *$L\ge1$ とする。$0\le m\le\ell^L$ ならば $\bar A_m(a,b)$ は $(a,b)\bmod\ell^L$ だけの関数である。*

**証明.** $(a,b)\mapsto(a+\ell^Lu,\ b+\ell^Lv)$ による $\bar A_m$ の変化を見る。
$N=pa+qb\mapsto N+\ell^L(pu+qv)$ なので、**$N$ の第 $0,\dots,L-1$ 桁は変わらない**。

**(i) $m<\ell^L$**: 補題 J0 の通り $\binom Nm\bmod\ell$ は第 $0,\dots,L-1$ 桁だけで決まるので不変。

**(ii) $m=\ell^L$**: $m_L=1$、他の桁は $0$ なので $\binom{N}{\ell^L}\equiv\binom{N_L}{1}=N_L$。
下位桁が変わらないので第 $L$ 桁への繰り上がりはなく、$N_L\mapsto N_L+(pu+qv)$（$\bmod\ \ell$）。
したがって

$$\bar A_{\ell^L}(a+\ell^Lu,b+\ell^Lv)-\bar A_{\ell^L}(a,b)
=\sum_{(p,q)}\bar c_{pq}\,\overline{(pu+qv)}=\overline{A_1(u,v)}=0,$$

最後の等号は cycle 18 補題 A2 (1)（$A_1\equiv0$ は整数としての恒等式で、
$D(z,w)=D(z^{-1},w^{-1})$ から従う）。$\blacksquare$

> **系 J2a.** *$\theta(a,b)\le\ell^L$ ならば $\theta$ は $(a,b)\bmod\ell^L$ だけで決まる。*

**証明.** $\theta$ の判定に使う添字は $m\le\theta\le\ell^L$ だけで、そのすべてに定理 J2 が使える。$\blacksquare$

$L=1$ とすると cycle 18 補題 A3・系 A3′ をそのまま再現する。
**これが「Lucas を第 2 桁・第 3 桁へ延長する」の答えである**: 延長すると閾値は $\ell,\ell^2,\ell^3,\dots$ と上がり、
$m=\ell^L$ で第 $L$ 桁が入りかけるが $A_1=0$ でちょうど打ち消される、という同じ機構が各桁で繰り返す。

### 2.3 命題 J2′（閾値が鋭いのはいつか）

cycle 18 命題 G は「$m=\ell+1$ で破れ**うる**」までしか言っていない。実際に破れるかは決められる。

> **命題 J2′.** *$L\ge1$ とする。$m=\ell^L+1$ での digit 安定性の破れは*
> $$\bar A_{\ell^L+1}(a+\ell^Lu,b+\ell^Lv)-\bar A_{\ell^L+1}(a,b)
> =\bar B\bigl((a,b),(u,v)\bigr),\qquad
> \bar B(x,y):=\sum_{(p,q)}\bar c_{pq}\,\overline{(px_1+qx_2)}\ \overline{(py_1+qy_2)}$$
> *で与えられる。$\bar B$ は $L$ に依らない対称双一次形式で、$\bar B(x,x)=\overline{2A_2(x)}$ を満たす
> （すなわち $\bar A_2$ の極形式である）。したがって*
> - *$\ell$ が奇素数のとき: $m=\ell^L+1$ で破れる $\iff\bar A_2\neq0\iff k=2$。*
> - *$\ell=2$ のとき: 破れる $\iff\bar A_2$ が $\mathbb{F}_2[T,S]$ の平方でない。*

**証明.** $m=\ell^L+1$ は $m_0=1$, $m_L=1$、他 $0$ なので $\binom{N}{\ell^L+1}\equiv N_0N_L$。
$N_0$ は不変、$N_L$ は $(pu+qv)$ だけ変化するので差は $\sum\bar c_{pq}N_0\,\overline{(pu+qv)}$、これが $\bar B$。
$L$ が現れないので $L$ に依らない。$\bar B(x,x)=\sum\bar c_{pq}\overline{(px_1+qx_2)^2}$ で、
$N^2=2\binom N2+N$ より $=\overline{2A_2(x)+A_1(x)}=\overline{2A_2(x)}$（$A_1=0$）。

$\ell$ 奇なら $2$ は単元なので $\bar B$ は $\bar A_2$ の極形式であり、$\bar B=0\iff\bar A_2=0$
（標数 $\neq2$ では二次形式は極形式から復元できる）。cycle 18 補題 A2 (3) より
$\bar A_2=0\iff k\ge3$、つまり $\bar A_2\neq0\iff k=2$（cycle 14 補題 5.2 より $k\ge2$）。

$\ell=2$ なら $\bar B(x,x)=0$ なので $\bar B$ は交代形式で、$\bar B=\gamma\cdot\det$（$\gamma\in\mathbb{F}_2$）。
$\bar B$ が $\bar A_2$ の極形式であることは変わらず、$\mathbb{F}_2$ 上で二次形式の極形式が消えることと
その形式が平方（Frobenius の像）であることは同値である。$\blacksquare$

**注 2.3.** これで cycle 18 §4.2 の「破れうる場所は $m=\ell+1$ ちょうど」は
「**破れる場所は $m=\ell^L+1$ で、破れるかどうかは $\bar A_2$ が決める**」に精密化された。
とくに **$k=2$（生成的な場合）で $\ell$ が奇なら閾値は必ず鋭い**。

### 2.4 系 J3（$\theta$ の局所定数性と有界性）

> **系 J3.**
> 1. $\theta(P)<\infty$ なる $P\in\mathbb{P}^1(\mathbb{Z}_\ell)$ では $\theta$ は局所定数である。
>    具体的には $\ell^L\ge\theta(P)$ なる $L$ について、$P$ の $\bmod\ \ell^L$ 近傍で $\theta$ は一定。
> 2. $\theta$ が $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上で至る所有限ならば、$\theta$ は**有界**であり、
>    ある $L$ について $\mathbb{P}^1(\mathbb{Z}/\ell^L)$ を経由する。

**証明.** 1 は系 J2a。2 は 1 と $\mathbb{P}^1(\mathbb{Z}_\ell)$ のコンパクト性から:
$\theta$ が局所定数なら $\{\theta=t\}$ は開集合で、これらが被覆をなすので有限部分被覆が取れ、
値の集合は有限、したがって有界。$\theta^{\max}$ を最大値、$\ell^L\ge\theta^{\max}$ とすると
1 より各点の $\bmod\ \ell^L$ 近傍で一定なので $\mathbb{P}^1(\mathbb{Z}/\ell^L)$ を経由する。$\blacksquare$

**注 2.4.** 「至る所有限」は空虚な仮定ではない。$\theta=\infty$ になるのは
$\bar E$ が 1 径数部分群上で恒等的に消えるときだけ（cycle 18 補題 A5）で、
これは $\mathbb{P}^1(\mathbb{Z}_\ell)$ の閉集合である（§7.2）。

---

## 3. ファイバー上の Newton 公式

系 J3 は「$\theta$ が有限なら有界」と言うだけで、**どの $L$ で止まるか**を教えない。
それを決めるのが本節である。cycle 18 §6.1 が要求した
「$\theta_M(a,b)$ を $a,b$ の $\ell$ 進展開の桁ごとに記述する式」がここで得られる。

### 3.1 準備（Hasse 微分と Frobenius）

**基点** $P_0=(1:c)$ を固定する。ここで $c\in\mathbb{Z}_\ell$ であって、
$c\in\{0,\dots,\ell-1\}$ に限らない（この点を取り違えたのが本サイクル最大の誤り。§11.2）。
$P_0$ を含む $\bmod\ \ell$ 方向のファイバーは $\{(1:c+\ell\beta):\beta\in\mathbb{Z}_\ell\}$ であり、
**同じファイバーをその中のどの点から見るかで以下の $e_j$ は変わる**。
（$c\equiv\infty$ の側、すなわち $(0{:}1)$ 近傍では $z,w$ の役割を入れ替える。以下同様。）

> **定義.** $D_j(z,w):=\sum_{(p,q)}\bar c_{pq}\binom qj z^pw^q\in\mathbb{F}_\ell[z,w]$ と置く
> （$\tilde E$ の乗法的な第 $j$ Hasse 微分）。$z^pw^q(1+u)^q=\sum_j\binom qj z^pw^qu^j$ より
> $$\bar{\tilde E}\bigl(z,w(1+u)\bigr)=\sum_{j\ge0}D_j(z,w)\,u^j\quad(\text{有限和},\ j\le\max q). \tag{3.1}$$
> $\psi_j(x):=D_j\bigl(1+x,(1+x)^c\bigr)\in\mathbb{F}_\ell[x]$、
> $e_j:=\mathrm{ord}_{x=0}\psi_j\in\mathbb{N}\cup\{\infty\}$、$\lambda_j:=$ その最低次係数。
> とくに $\psi_0=\overline{\Phi_{(1,c)}}$、$e_0=\theta(P_0)$。

**割り算は現れない**（$\binom qj$ は整数）。cycle 18 注 2.1 と同じ理由で、これが本質的である。

> **補題 J4a.** *$\beta\in\mathbb{Z}_\ell$、$v:=v_\ell(\beta)$、$r:=v+1$ とすると、$\mathbb{F}_\ell[[x]]$ の中で*
> $$(1+x)^{c+\ell\beta}=(1+x)^c\bigl(1+x^{\ell}\bigr)^{\beta},\qquad
> u:=(1+x^\ell)^\beta-1=\beta_v\,x^{\ell^{r}}+(\text{高次}),$$
> *すなわち $\mathrm{ord}_x u=\ell^{r}$、最低次係数は $\beta$ の第 $v$ 桁 $\beta_v\neq0$ である（$\beta\neq0$ のとき）。*

**証明.** $\mathbb{F}_\ell$ 上 $(1+x)^\ell=1+x^\ell$（Frobenius）。$\beta\in\mathbb{Z}_\ell$ に対する
$(1+y)^\beta=\sum_m\binom\beta my^m$ は補題 J0 により well-defined で、
$\binom\beta m\equiv\prod_i\binom{\beta_i}{m_i}$（Lucas の $\mathbb{Z}_\ell$ への連続延長）。
$m\ge1$ でこれが $0$ でない最小の $m$ は、全ての $i$ で $m_i\le\beta_i$ を要するから $m=\ell^{v}$ であり、
そのとき値は $\binom{\beta_v}{1}=\beta_v$。$y=x^\ell$ を代入して $\mathrm{ord}_x=\ell\cdot\ell^v=\ell^r$。$\blacksquare$

### 3.2 定理 J4（ファイバー Newton 公式）

> **定理 J4.** *記号を上の通りとし、$\beta\neq0$、$r=1+v_\ell(\beta)$ とする。*
> $$\overline{\Phi_{(1,c+\ell\beta)}}=\sum_{j\ge0}\psi_j\,u^j,\qquad
> \mathrm{ord}_x\bigl(\psi_ju^j\bigr)=e_j+j\ell^{r}. \tag{3.2}$$
> *したがって $\Lambda(r):=\min_{j\ge0}\bigl(e_j+j\ell^{r}\bigr)$、$J(r):=\{j:e_j+j\ell^r=\Lambda(r)\}$ と置くと*
> $$\theta(1,c+\ell\beta)\ \ge\ \Lambda(r),\qquad
> \text{$x^{\Lambda(r)}$ の係数}=\sum_{j\in J(r)}\lambda_j\,\beta_v^{\,j}. \tag{3.3}$$
> *とくに $|J(r)|=1$ ならば等号 $\theta=\Lambda(r)$ が成り立つ。*

**証明.** $(3.1)$ に $z=1+x$、$w=(1+x)^c$、$1+u=(1+x^\ell)^\beta$ を代入すると $(3.2)$。
補題 J4a より $u^j$ の最低次は $\beta_v^{\,j}x^{j\ell^r}$、$\psi_j$ の最低次は $\lambda_jx^{e_j}$ なので
$\psi_ju^j$ の最低次は $\lambda_j\beta_v^{\,j}x^{e_j+j\ell^r}$。次数 $\Lambda(r)$ の係数を集めると $(3.3)$。$\blacksquare$

**これが cycle 18 §6.1 の要求への答えである。** $\theta$ は $\beta$ の全桁には依存せず、
**まず $v_\ell(\beta)$（何桁目から $\beta$ が立つか）だけで決まり**、$\mathrm{argmin}$ が複数のときに限って
先頭桁 $\beta_v$（さらに打ち消しが起きればより深い桁）が効く。
$(e_j)_j$ を頂点とする折れ線の、傾きパラメータ $\ell^{r}$ に関する **Newton 多角形**である。

**注 3.1（幾何的な意味）.** $(3.2)$ は「$\bar E$ を $\mathbb{G}_m$ の 1 径数部分群へ制限する」操作が、
$\mathbb{F}_\ell$ 上では $\ell$ 冪 Frobenius によって $x\mapsto x^{\ell^r}$ という**純非分離な変数変換**に
なることを言っている。$M$ 依存の正体はこれである。

### 3.3 系 J5（有限判定条件）と、cycle 18 の条件との比較

> **系 J5.** *$e_0<\infty$ かつ すべての $j\ge1$ で $e_j+j\ell>e_0$ ならば、
> $P_0$ 上のファイバー全体で $\theta\equiv e_0=\theta(P_0)$ である。*

**証明.** $r\ge1$ なので $e_j+j\ell^{r}\ge e_j+j\ell>e_0$（$j\ge1$）。よって $J(r)=\{0\}$（一意）、
定理 J4 より $\theta=\Lambda(r)=e_0$。$\beta=0$ の点は $P_0$ 自身。$\blacksquare$

> **命題 J5′.** *$\theta(P_0)\le\ell$ ならば系 J5 の条件は自動的に満たされる。逆は成り立たない。*

**証明.** $\psi_1(0)=D_1(1,1)=\sum c_{pq}q=(\delta_w\tilde E)(1,1)=0$
（$\tilde E=z^rw^sE$、$E(1,1)=0$、$(\partial_wE)(1,1)=0$。cycle 18 §2.2）なので $e_1\ge1$、
よって $e_1+\ell\ge1+\ell>\ell\ge e_0$。$j\ge2$ なら $e_j+j\ell\ge2\ell>\ell\ge e_0$。
逆が成り立たないことは §6 の実例（$\ell=3$、$e_0=4>\ell$ だが条件は通る）が示す。$\blacksquare$

**したがって系 J5 は cycle 18 系 A3′ の真の拡張である。** 判定は $D$ の係数からの
$\mathbb{F}_\ell$ 上の有限計算（$e_j$ を $j\le\max q$ で求めるだけ）で済む。

---

## 4. レベル分解と一般の予言アルゴリズム

### 4.1 補題 J1（レベル分解 — $\varphi$ が相殺する）

> **補題 J1.** *仮定なしに次が成り立つ。*
> $$\Sigma_n=\sum_{M'=1}^{n}\Theta_{M'},\qquad
> \Theta_{M'}:=\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^{M'})}\hat\theta_{M'}(P). \tag{4.1}$$

**証明.** $(1.2)$ の和をレベルちょうど $M'$ の点で層別する。レベルちょうど $M'$ の点は、
原始 $\ell^{M'}$ 乗根 $g'$ を固定して $(\zeta,\xi)=(g'^a,g'^b)$、$(a,b)\in(\mathbb{Z}/\ell^{M'})^2$ が原始的
（$\ell$ で両方は割れない）なもの全体と 1 対 1 に対応し、個数は $\ell^{2M'}-\ell^{2M'-2}$。
$c\in(\mathbb{Z}/\ell^{M'})^\times$ による $(a,b)\mapsto(ca,cb)$ は Galois 作用 $\zeta\mapsto\zeta^c$ に対応し、
$\ell$ の上の素点は 1 つしかないので $v_\ell$ を保つ。この作用は自由で、軌道は $\mathbb{P}^1(\mathbb{Z}/\ell^{M'})$ の点、
軌道の大きさは $\varphi(\ell^{M'})$（検算: $(\ell+1)\ell^{M'-1}\cdot\varphi(\ell^{M'})=\ell^{2M'-2}(\ell^2-1)$ ✓）。よって

$$\sum_{\text{レベル }M'}v_\ell(E)=\sum_{P}\varphi(\ell^{M'})\cdot\frac{\hat\theta_{M'}(P)}{\varphi(\ell^{M'})}
=\sum_P\hat\theta_{M'}(P).\qquad\blacksquare$$

**$\varphi(\ell^{M'})$ がちょうど相殺する**のが要点である。cycle 18 §6.1 が
$\Sigma_n=\sum_{M'}\frac1{\varphi(\ell^{M'})}\sum_{\text{点}}\theta$ と書いていた式は、
$\mathbb{P}^1$ の点で数え直すとこの形になる。$\Theta_{M'}$ は $\mathbb{P}^1(\mathbb{Z}/\ell^{M'})$ 上の $\hat\theta$ の**単純和**である。

### 4.2 定理 B′（$\Phi$ の 2 付値 Newton 多角形）

> **定理 B′.** *$\zeta=g^a$, $\xi=g^b$（$g$ は原始 $\ell^M$ 乗根）とし、$\Phi_{(a,b)}\neq0$ とする。*
> $$\hat\theta_M(a,b)=\min_{m}\Bigl(\varphi(\ell^M)\,v_\ell\bigl(A_m(a,b)\bigr)+m\Bigr)
> \qquad\text{（最小点が一意のとき）}. \tag{4.2}$$

**証明.** $\tilde E(\zeta,\xi)=\Phi_{(a,b)}(\pi)=\sum_mA_m\pi^m$ で
$v_\ell(A_m\pi^m)=v_\ell(A_m)+m/\varphi(\ell^M)$。$\varphi(\ell^M)$ 倍すると $(4.2)$ の中身。
非アルキメデス的評価より、最小値が一意の $m$ で達成されるなら和の付値はその最小値に等しい。$\blacksquare$

**注 4.1（cycle 18 定理 B との関係）.** cycle 18 定理 B は $(4.2)$ の最小点が $m=\theta$ にある場合である。
実際 $v_\ell(A_\theta)=0$ なので $m=\theta$ の値は $\theta$、$m<\theta$ の項は $v_\ell(A_m)\ge1$ より
$\ge\varphi(\ell^M)+m_1$、$m>\theta$ の項は $>\theta$。したがって $\theta-m_1<\varphi(\ell^M)$ なら
最小点は $m=\theta$ で一意になり $\hat\theta=\theta$。**定理 B は定理 B′ の系である。**
逆に定理 B の条件が破れても $(4.2)$ は使えることがあり（$\ell=2$ トーラスがその例。§5.4）、
そこが本サイクルで射程が広がった点である。

**注 4.2（$\hat\theta\ne\theta$ が起きる向き）.** $(4.2)$ の最小値は $m=\theta$ の項 $\theta$ 以下なので、
**常に $\hat\theta_M\le\theta$** である。すなわち低次の $\ell$ 可除な係数が効くと、
測られる深さは $\theta$ より**浅くなる**。cycle 18 §4.3 の表の値が方向ごとに割れていたのは
この現象である（$\theta$ 自身が方向内で割れているとは限らない）。

### 4.3 定理 K（一般の予言アルゴリズム）

> **定理 K.** *各 $M'\le n$ と各 $P\in\mathbb{P}^1(\mathbb{Z}/\ell^{M'})$ で $(4.2)$ の最小点が一意ならば*
> $$\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)-2n+v_\ell(\kappa(X))
> +\sum_{M'=1}^{n}\ \sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^{M'})}\ \min_m\Bigl(\varphi(\ell^{M'})\,v_\ell\bigl(A_m(P)\bigr)+m\Bigr). \tag{4.3}$$
> *右辺は $D$ の係数からの有限計算だけで決まる（塔の値も円分体での計算も使わない）。*

**証明.** $(1.2)$ + 補題 J1 + 定理 B′。$\blacksquare$

これは**閉形式ではなく、$n$ とともに計算量が増えるアルゴリズム**である
（レベル $M'$ の項数は $(\ell+1)\ell^{M'-1}$）。閉形式にするには和を潰す必要があり、
それが §5 の内容である。ただしアルゴリズムとしては、**cycle 16・17・18 のどの定理よりも仮定が弱い**。

### 4.4 $\mathbb{R}$ を使っていないこと（明示）

$(4.3)$ で使ったのは、(a) 整数係数多項式 $\Phi_{(a,b)}\in\mathbb{Z}[x]$ の係数の $\ell$ 進付値、
(b) $\mathbb{Q}(\zeta_{\ell^{M}})$（$\mathbb{Q}$ の可算な代数拡大）の $\ell$ の上の唯一の素点での付値、
(c) $\mathbb{F}_\ell$ 上の有限計算、(d) $\mathbb{Z}_\ell$ の桁（可算な記述をもつ）。
**$\mathbb{R}$ へは一度も脱出していない。** $(4.3)$ の値は有理数（実際は整数）である。
$\mathbb{P}^1(\mathbb{Z}_\ell)$ は非可算だが、上で使ったのは有限レベル $\mathbb{P}^1(\mathbb{Z}/\ell^L)$ への
還元と系 J3 のコンパクト性（有限被覆の存在）だけで、非可算集合の元を個別に扱ってはいない。

---

## 5. 閉形式

### 5.1 定理 J6（$\theta$ が至る所有限 ⇒ 型 II）

> **定理 J6.** *次を仮定する。*
> - *(i) $\theta$ は $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上で至る所有限（系 J3 より有界。$\theta^{\max}$ を最大値、
>   $\theta$ が経由するレベルの 1 つを $L$ とする）。*
> - *(ii) $n_1\ge L$ を $\theta^{\max}-2<\varphi(\ell^{n_1})$ を満たすように取る。*
>
> *このとき $n\ge n_1$ で*
> $$\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+\frac{\Theta_L}{\varphi(\ell^{L})}\,\ell^{n}-2n+\nu, \tag{5.1}$$
> *$\Theta_L=\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^{L})}\theta(P)$、$\nu$ はレベル $<n_1$ からの定数。
> とくに **$n\ell^n$ 項は現れない（型 II）**。係数 $\Theta_L/\varphi(\ell^L)$ は $L$ の取り方に依らない。*

**証明.** $M'\ge n_1$ の点では $\theta\le\theta^{\max}$、$m_1\ge2$（cycle 18 補題 A2 (1)）だから
$\theta-m_1\le\theta^{\max}-2<\varphi(\ell^{n_1})\le\varphi(\ell^{M'})$、注 4.1 より $\hat\theta_{M'}=\theta$。
$\theta$ は $\mathbb{P}^1(\mathbb{Z}/\ell^L)$ を経由し、$\mathbb{P}^1(\mathbb{Z}/\ell^{M'})\to\mathbb{P}^1(\mathbb{Z}/\ell^{L})$ の
ファイバーは一様に $\ell^{M'-L}$ 個なので $\Theta_{M'}=\ell^{M'-L}\Theta_L$。よって補題 J1 より

$$\Sigma_n=\Sigma_{n_1-1}+\Theta_L\sum_{M'=n_1}^{n}\ell^{M'-L}
=\Sigma_{n_1-1}+\Theta_L\frac{\ell^{n-L+1}-\ell^{n_1-L}}{\ell-1}.$$

$\ell^n$ の係数は $\Theta_L\ell^{1-L}/(\ell-1)=\Theta_L/\varphi(\ell^L)$、残りは定数。$(1.2)$ に代入して $(5.1)$。
$L$ を $L'>L$ に取り替えると $\Theta_{L'}=\ell^{L'-L}\Theta_L$、$\varphi(\ell^{L'})=\ell^{L'-L}\varphi(\ell^L)$ で
比は不変。$\blacksquare$

> **系 J6a.** *cycle 18 定理 C は定理 J6 の $L=1$（$\theta\le\ell$、$n_1=1$）の場合である。*

**証明.** $\theta(P)\le\ell$ なら命題 J5′ + 系 J5 より $\theta$ は $\mathbb{P}^1(\mathbb{F}_\ell)$ を経由し、
$\Theta_1=\Theta$、$\varphi(\ell)=\ell-1$ で $(5.1)$ の係数は $\Theta/(\ell-1)$。$\blacksquare$

**定理 J6 が cycle 18 定理 C より広い点**は、$\theta\le\ell$ を要求せず、
$\theta$ が有限で（系 J5 などにより）どこかのレベルで止まりさえすればよいことである。
$\theta\ge\ell+1$ でも型 II の閉形式が出る。実例が §6 である。

### 5.2 定理 J7（$\theta=\infty$ の $\mathbb{Z}_\ell$ 点が $n\ell^n$ 項を生む）

> **定義.** $S_\infty:=\{P\in\mathbb{P}^1(\mathbb{Z}_\ell):\theta(P)=\infty\}$ と置く。
> $P\in S_\infty$ に対し、**$P$ 自身を基点として** §3.1 の $e_j$ を取り
> $j^*(P):=\min\{j\ge1:e_j<\infty\}$ と定める。

> **注意（本サイクルで実際に踏んだ落とし穴。§11.2）**: $S_\infty$ は
> $\mathbb{P}^1(\mathbb{F}_\ell)$ の方向の集合**ではなく** $\mathbb{P}^1(\mathbb{Z}_\ell)$ の点の集合である。
> 方向 $(1{:}\ell-1)$ の整数代表 $(1,\ell-1)$ と $\mathbb{Z}_\ell$ の点 $(1,-1)$ は**別の点**であり、
> 前者で $\theta$ が有限、後者で $\theta=\infty$ ということが実際に起きる（§5.3 の族がそうである）。
> $e_j$ は基点に依存するので、基点は $S_\infty$ の点に取らなければならない。

> **補題 J7a.** *$\bar{\tilde E}\neq0$ ならば $j^*(P)<\infty$ である。*

**証明.** すべての $j$ で $\psi_j\equiv0$ なら $(3.1)$ より
$\bar{\tilde E}\bigl((1+x),(1+x)^c(1+u)\bigr)\equiv0$ が $\mathbb{F}_\ell[[x]][[u]]$ で成り立ち、
$(x,u)$ は $(z,w)$ の形式的座標系なので $\bar{\tilde E}=0$。$\blacksquare$

> **定理 J7.** *次を仮定する。*
> - *(F) $S_\infty$ は有限集合である。*
> - *(N) ある $r_0\ge1$ が存在して、半径 $\ell^{-r_0}$ の球 $B(P,\ell^{-r_0})$（$P\in S_\infty$）は
>   互いに素であり、各 $P\in S_\infty$ を基点とする $\Lambda(r)$ の $\mathrm{argmin}$ が
>   すべての $r\ge r_0$ で一意である。*
> - *(B\*) $n_1$ が存在して、レベル $M'\ge n_1$ のすべての点で定理 B′ の最小点が一意である。*
>
> *このとき $\mathrm{ord}_\ell(\kappa_n)$ の $n\ell^n$ 項の係数は*
> $$b=\sum_{P\in S_\infty} j^*(P). \tag{5.2}$$
> *とくに $S_\infty=\emptyset$（$\theta$ が至る所有限）なら $b=0$（定理 J6 と整合）。*

**証明.** 補題 J1 より $\Theta_{M'}$ の $M'\ell^{M'}$ 項の係数を求めればよい。
$U:=\mathbb{P}^1(\mathbb{Z}_\ell)\setminus\bigcup_{P\in S_\infty}B(P,\ell^{-r_0})$ と置く。
$U$ はコンパクトで $\theta$ は $U$ 上至る所有限、よって系 J3 の議論より $U$ 上で有界、
ある $L_U$ で止まる。$M'\ge\max(r_0,L_U,n_1)$ とする。

**(a) $U$ に含まれる球の寄与.** そこでは $\hat\theta_{M'}=\theta$ が $\mathbb{P}^1(\mathbb{Z}/\ell^{L_U})$ を
経由して一定なので、寄与は $\ell^{M'-L_U}\cdot(\text{定数})$、すなわち $\ell^{M'}$ の定数倍。
**$M'\ell^{M'}$ 項を持たない。**

**(b) $P\in S_\infty$ のまわりの球の寄与.** $P$ を基点にすると、$B(P,\ell^{-r_0})$ 内の
レベル $M'$ の球は $\beta$（$v:=v_\ell(\beta)\ge r_0-1$）で添字づけられ、
$v\le M'-2$ の層は $\varphi(\ell^{M'-1-v})$ 個、$\beta\equiv0$ の球（$P$ を含む）が 1 個である。
$R'\ge r_0$ を $r\ge R'$ で $\Lambda(r)=e_{j^*}+j^*\ell^{r}$ となるように取る
（$j>j^*$ の項は傾きが大きいので $r$ が大きければ必ず負ける）。ここで $v\le M'-2$ に対し

$$\varphi(\ell^{M'-1-v})\cdot\ell^{v+1}=(\ell^{M'-1-v}-\ell^{M'-2-v})\ell^{v+1}=\ell^{M'}-\ell^{M'-1}=\varphi(\ell^{M'})$$

は **$v$ に依らない**。よって $v$ が $R'-1$ から $M'-2$ まで走る $M'-R'$ 個の層の寄与は

$$\sum_{v=R'-1}^{M'-2}\varphi(\ell^{M'-1-v})\bigl(e_{j^*}+j^*\ell^{v+1}\bigr)
=e_{j^*}\bigl(\ell^{M'-R'}-1\bigr)+j^*\varphi(\ell^{M'})\,(M'-R').$$

第 2 項が $M'\ell^{M'}$ 項を生み、その係数は $j^*(P)\,(1-\ell^{-1})$。
$v<R'-1$ の有限個の層と、$P$ を含む最内球（そこでは $\hat\theta_{M'}=\varphi(\ell^{M'})+\theta'$。§5.3 (3)）は
$\ell^{M'}$ の定数倍と定数しか出さない。

**(c) 合算.** $\Theta_{M'}=\beta M'\ell^{M'}+O(\ell^{M'})$、$\beta=\frac{\ell-1}{\ell}\sum_{P\in S_\infty}j^*(P)$。
$\sum_{M'=1}^nM'\ell^{M'}=\frac{\ell-(n+1)\ell^{n+1}+n\ell^{n+2}}{(1-\ell)^2}$ の $n\ell^n$ 係数は
$\frac{\ell}{\ell-1}$ なので、$\Sigma_n$（したがって $\mathrm{ord}_\ell(\kappa_n)$）の $n\ell^n$ 係数は
$\beta\cdot\frac{\ell}{\ell-1}=\sum_{P\in S_\infty}j^*(P)$。$\blacksquare$

**これが cycle 16 §7 の型分類に対する答えである**: 型 III（$n\ell^n$ 項が出る）になるのは
**$\bar E$ が 1 径数部分群上で恒等的に消える $\mathbb{Z}_\ell$ 点があるとき、そのときに限る**（上の仮定の下で）。
cycle 18 §4.5 が「第 3 の破れ方」として例だけ挙げた $\theta=\infty$ は、
**例外事象ではなく型 III の唯一の源**だった。

### 5.3 定理 J8（奇素数の型 III 塔の族と、その閉形式）

cycle 16 が持っていた型 III の実例は $\ell=2$ トーラス 1 個だけだった（同 定理 D2）。
定理 J7 を使うと、**すべての奇素数に対して型 III 塔とその閉形式が作れる。**

> **定理 J8.** *$\ell$ を奇素数、$X_\ell$ を 1 頂点の bouquet で voltage $(1,0)$ の
> ループを $\ell-1$ 本、$(0,1)$ のループを 1 本持つものとする。このとき仮定 (H) が成り立ち、
> $\mu=0$、$v_\ell(\kappa(X_\ell))=0$、$k=2$、$z_H=2$ で、**すべての $n\ge0$** で*
> $$\mathrm{ord}_\ell(\kappa_n)=2n\,\ell^{n}+2\,\ell^{n}-2. \tag{5.3}$$
> *すなわち $b=2$、$c=2$、$d=0$、$e=-2$、$a=0$、$n_0=0$ の型 III 塔である。*

**証明.** $D=(\ell-1)(2-z-z^{-1})+(2-w-w^{-1})$、係数の gcd は 1 なので $\mu=0$、$E=D$。
1 頂点グラフなので $\kappa(X_\ell)=1$、$v_\ell=0$。
$\tilde E=zwE=-(\ell-1)w(z-1)^2-z(w-1)^2$、$\bmod\ \ell$ で $-(\ell-1)\equiv1$ より

$$\bar{\tilde E}=w(z-1)^2-z(w-1)^2. \tag{5.4}$$

$H=T^2-S^2$、$k=2$、$Z_H=\{(1{:}1),(1{:}-1)\}$、$z_H=2$。

**(1) $S_\infty$ を厳密に決める.** $2-z-z^{-1}=-(z-1)^2/z$ より、$s:=(1+x)^a-1$、$t:=(1+x)^b-1$ と置くと
$\mathbb{F}_\ell[[x]]$（正確には $(1+x)$ を可逆にした環）で

$$\bar E\bigl((1+x)^a,(1+x)^b\bigr)=\frac{s^2}{1+s}-\frac{t^2}{1+t}
=\frac{(s-t)\bigl(s+t+st\bigr)}{(1+s)(1+t)}.$$

（$-(\ell-1)\equiv1$ を使った。）これが $0$ になるのは $s=t$ すなわち $(1+x)^a=(1+x)^b$ か、
$s+t+st=(1+s)(1+t)-1=0$ すなわち $(1+x)^{a+b}=1$ のときだけである。
$\mathbb{F}_\ell[[x]]$ で $(1+x)^c=1\iff c=0$（$c\in\mathbb{Z}_\ell$）なので

$$S_\infty=\{(a{:}b):a=b\}\cup\{(a{:}b):a+b=0\}=\{(1{:}1),\,(1{:}-1)\}. \tag{5.5}$$

**$\ell$ が奇なら $1\not\equiv-1\pmod\ell$ なので、この 2 点は異なる $\bmod\ \ell$ 方向に属し、
半径 $\ell^{-1}$ の球はすでに互いに素である**（定理 J7 の (N) が $r_0=1$ で満たされる）。
（$\ell=2$ では $1\equiv-1$ なので同じ方向に入る。これが §5.4 の違いを生む。）

**(2) 各点での $e_j$.** $(5.4)$ から $D_0=\bar{\tilde E}$、$D_1=w(z-1)^2-2zw(w-1)$、$D_2=-zw^2$、
$D_j=0$（$j\ge3$）。

- *$P=(1{:}1)$ を基点に*: $z=w=1+x$ で $\psi_0=(1+x)x^2-(1+x)x^2=0$（$\theta=\infty$ ✓）。
  $\psi_1=(1+x)x^2-2(1+x)^2x$ は $\ell$ 奇より $-2\neq0$ で $e_1=1$、$\psi_2=-(1+x)^3$ で $e_2=0$。
  よって $j^*=1$、$\Lambda(r)=\min(1+\ell^r,\,2\ell^r)=1+\ell^{r}$ で **$|J(r)|=1$（$1+\ell^r<2\ell^r$）**。
- *$P=(1{:}-1)$ を基点に*: $E(z,w)=E(z,w^{-1})$（$2-w-w^{-1}$ は $w\mapsto w^{-1}$ で不変）なので
  $\theta(a,b)=\theta(a,-b)$ が成り立ち、$(1{:}1)$ と同じ値（$j^*=1$、$\Lambda(r)=1+\ell^r$）になる。
- *非退化方向（$\ell-1$ 本）*: $(1{:}0)$ では $\psi_0=x^2$、$(0{:}1)$ では $\psi_0=-x^2$、
  $(1{:}c)$（$c\not\equiv0,\pm1$）では $\psi_0=x^2\bigl[(1+x)^c-(1+x)c^2+O(x)\bigr]$ で最低次係数 $1-c^2\neq0$。
  いずれも $e_0=2\le\ell$ なので命題 J5′ + 系 J5 より $\theta\equiv2$（ファイバー上定数）。

**(3) $\theta=\infty$ の点での $\hat\theta$.** $(1,1)$ では $\Phi_{(1,1)}=\tilde E(1+x,1+x)=-\ell(1+x)x^2$、
すなわち $A_2=A_3=-\ell$、他は $0$。$(4.2)$ の値は $m=2$ で $\varphi(\ell^{M'})+2$、$m=3$ で
$\varphi(\ell^{M'})+3$ なので**最小点は一意**で

$$\hat\theta_{M'}=\varphi(\ell^{M'})+2. \tag{5.6}$$

**(4) 定理 B′ の適用可能性.** 非退化方向は $\theta=2$、$m_1\ge2$ より常に可。
退化方向のファイバーの点（$v=v_\ell(\beta)\le M'-2$）は $\theta=1+\ell^{v+1}\le1+\ell^{M'-1}$ で、
$\theta-2\le\ell^{M'-1}-1<\ell^{M'-1}(\ell-1)=\varphi(\ell^{M'})$（$\ell\ge3$ より）。よって $\hat\theta=\theta$。

**(5) $\Theta_{M'}$ の計算.** 非退化方向は $\ell-1$ 本、各ファイバー $\ell^{M'-1}$ 点で値 2:
$2(\ell-1)\ell^{M'-1}$。退化方向 1 本あたり

$$\sum_{v=0}^{M'-2}\varphi(\ell^{M'-1-v})\bigl(1+\ell^{v+1}\bigr)+\bigl(\varphi(\ell^{M'})+2\bigr)
=\bigl(\ell^{M'-1}-1\bigr)+(M'-1)\varphi(\ell^{M'})+\varphi(\ell^{M'})+2
=\ell^{M'-1}+1+M'\varphi(\ell^{M'})$$

（$\sum_{v=0}^{M'-2}\varphi(\ell^{M'-1-v})=\ell^{M'-1}-1$、および (b) で使った
$\varphi(\ell^{M'-1-v})\ell^{v+1}=\varphi(\ell^{M'})$ が $M'-1$ 個）。退化方向は 2 本なので

$$\Theta_{M'}=2(\ell-1)\ell^{M'-1}+2\bigl(\ell^{M'-1}+1+M'\varphi(\ell^{M'})\bigr)
=2\ell^{M'}+2+2M'\varphi(\ell^{M'})\qquad(M'\ge1). \tag{5.7}$$

**(6) 総和.** $\sum_{M'=1}^n\ell^{M'}=\frac{\ell^{n+1}-\ell}{\ell-1}$、
$\sum_{M'=1}^nM'\ell^{M'}=\frac{\ell+\ell^{n+1}\bigl(n(\ell-1)-1\bigr)}{(\ell-1)^2}$ を $(5.7)$ に入れると

$$\Sigma_n=\frac{2\ell^{n+1}-2\ell}{\ell-1}+2n+\frac{2+2n(\ell-1)\ell^n-2\ell^n}{\ell-1}
=2n\ell^n+2\ell^n-2+2n,$$

$(1.2)$ より $\mathrm{ord}_\ell(\kappa_n)=\Sigma_n-2n=2n\ell^n+2\ell^n-2$。$n=0$ で $0$ となり底グラフと合う。$\blacksquare$

**$\ell=3,5$ での照合**（Matrix-Tree 定理による塔の値の独立計算。フィットパラメータ 0 個）:

| $\ell$ | $n=0$ | $n=1$ | $n=2$ | $n=3$ |
|---|---|---|---|---|
| 3（予言 = 実測） | 0 | 10 | 52 | 214 |
| 5（予言 = 実測） | 0 | 18 | 148 | （段数の壁） |

### 5.4 $\ell=2$ トーラス — 結論は当たるが、証明は覆っていない

$\ell=2$、トーラス（$(1,0),(0,1)$）では $\bar{\tilde E}=w(z-1)^2+z(w-1)^2$、
$H=(T+S)^2$、$Z_H=\{(1{:}1)\}$（$\bmod\ 2$ の方向は 1 本しかない）。
しかし $\mathbb{P}^1(\mathbb{Z}_2)$ の点としては §5.3 (1) と同じ計算により

$$S_\infty=\{(1{:}1),\,(1{:}-1)\}$$

で **2 点**である（$\ell=2$ では $1\equiv-1\bmod2$ なので、この 2 点は同じ $\bmod\ 2$ 方向に入り、
$2$ 進距離 $1/2$ しか離れていない）。各点で $\psi_1\equiv w(z-1)^2$ なので $e_1=2$、$j^*=1$。したがって

$$b=\sum_{P\in S_\infty}j^*(P)=1+1=2,$$

これは **cycle 16 定理 D2 の真の値 $b=2$ と一致する**。

**しかし定理 J7 の仮定はこの塔で破れている。** $P=(1{:}1)$ を基点にすると
$\Lambda(r)=\min(2+2^r,\,2^{r+1})$ は $r=1$ で $4=4$ と同点（$|J(1)|=2$）で、
先頭係数は $\lambda_1\beta_0+\lambda_2\beta_0^2=1+1=0$ となり実際に打ち消す。
これは $r=1$ の球がもう一方の $\theta=\infty$ 点 $(1{:}-1)$ を含んでいるためで、
仮定 (N) の「球が互いに素になる $r_0$」は $r_0=2$ でなければならない。
さらに定理 B′ の最小点にも同点が生じる:
$(a,b)=(1,3)$、$M=3$ では $A_2=-10$（$m=2$ の値 $4\cdot1+2=6$）と
$A_6$（$v_2=0$、値 $6$）が同点で、実際の $\hat\theta_3(1,3)=8$ は
どちらの候補値 $6$ よりも大きい。**すなわち (B\*) が破れ、$\Theta_{M'}$ の定数項が
定理 J7 の計算とずれる**（レベル 3 では定理 B′ の和 $40$ に対し真値 $\Theta_3=44$）。

**したがって $\ell=2$ トーラスについては、$(5.2)$ が当たることは照合であって証明ではない。**
主要項（$M'\ell^{M'}$ の係数、したがって $b$）は同点の影響を受けないので当たるが、
$c,d,e$ の各係数は定理 J7 の議論では出ない。cycle 16 が $\ell=2$ トーラスに
別の議論（同 補題 5.5）を要したのはこのためである。

**（前サイクルとの関係）** cycle 18 命題 F は「$\ell=2,3$ の退化塔は定理 C の射程外」だった。
本サイクルの定理 J6・J7 は $\ell=3$ の退化塔を射程に入れた（§6、§5.3）が、
**$\ell=2$ は依然として一般には射程外**である。ただしその理由は
「$\theta\ge k+1$ で $\ell$ が小さすぎる」（命題 F）ではなく、
「$S_\infty$ の 2 点が $\bmod\ \ell$ で分離されず、打ち消しが起きる」ことである。

---

## 6. cycle 18 §4.4 の観察を、証明された判定条件へ格上げする

cycle 18 §4.4 は次を **数値支持どまり** と明記して残していた。

> $\ell=3$、bouquet $(1,0),(0,1),(1,1)$ は $k=2$、$z_H=1$、$\theta(1{:}1)=4=\ell+1$ で定理 C の
> 仮定を満たさない。しかし実測では $M=1,2,3$ のいずれでも帯上の値は 4 で一定であり、
> $\Theta=10$ を入れた式が塔の実測と一致する。**これは証明ではない。**

系 J5 でこれは**証明される**。

**計算.** $\tilde E=zwD=-w(z-1)^2-z(w-1)^2-(zw-1)^2$。
$H=T^2+TS+S^2=(T-S)^2$（$\mathbb{F}_3$ では $1\equiv-2$）、$Z_H=\{(1{:}1)\}$、$z_H=1$、$k=2$。

方向 $(1{:}1)$（$z=w=1+x$）で

$$E(z,z)=2(2-z-z^{-1})+(2-z^2-z^{-2})=\frac{-x^2\,(x^2+6x+6)}{(1+x)^2},$$

$\bmod\ 3$ で $x^2+6x+6\equiv x^2$ なので $\psi_0\ \propto\ x^4$、すなわち $e_0=\theta(1{:}1)=4=\ell+1$。
さらに

$$\psi_1=-(1+x)x^2-2x(1+x)^2(3+x)\ \equiv\ -2x^3(1+x)\pmod 3\ \Rightarrow\ e_1=3,$$
$$\psi_2=-zw^2-z^2w^2\big|_{z=w=1+x}=-(1+x)^3\bigl(2+x\bigr)\ \Rightarrow\ e_2=0,\qquad \psi_j=0\ (j\ge3).$$

系 J5 の条件は $e_1+\ell=3+3=6>4=e_0$、$e_2+2\ell=0+6=6>4$。**通る。**
よって $\theta\equiv4$ が方向 $(1{:}1)$ のファイバー**全体**（$\mathbb{P}^1(\mathbb{Z}_3)$ の中の $3$ 進開球全体）で成り立つ。
非退化な 3 方向は $\theta=2\le\ell$ なので系 A3′ でファイバー上定数。
したがって **$\theta$ は $\mathbb{P}^1(\mathbb{F}_3)$ を経由し、$\Theta_1=2+2+2+4=10$。**

**定理 J6 の適用と、低レベルの直接計算.** $\theta^{\max}=4$、$m_1\ge2$ なので
$\theta^{\max}-2=2<\varphi(3^{M'})$ は $M'\ge2$ で成り立つ（$\varphi(9)=6$）。
$M'=1$ では $\varphi(3)=2$ で成り立たないので、レベル 1 は**直接計算する**。
$(a,b)=(1,1)$ で $\Phi_{(1,1)}(x)=\tilde E(1+x,1+x)=-x^2(x^2+6x+6)=-6x^2-6x^3-x^4$、すなわち
$A_2=A_3=-6$、$A_4=-1$。定理 B′ の値は
$m=2$: $2\cdot1+2=4$、$m=3$: $2\cdot1+3=5$、$m=4$: $2\cdot0+4=4$。
**最小点が一意でない**ので定理 B′ は使えず、$\mathbb{Z}[\zeta_3]$ で直接評価する。
$\pi=\zeta_3-1$ は $\pi^2=-3\zeta_3$ を満たすので

$$\Phi_{(1,1)}(\pi)=-6\pi^2-6\pi^3-\pi^4=18\zeta_3-6\pi^3-9\zeta_3^2=9\zeta_3(2-\zeta_3)-6\pi^3.$$

$N(2-\zeta_3)=7$ より $2-\zeta_3$ は単元、$v_3\bigl(9\zeta_3(2-\zeta_3)\bigr)=2$、$v_3(6\pi^3)=1+\tfrac32=\tfrac52>2$。
よって $v_3=2$、$\hat\theta_1=\varphi(3)\cdot2=4$。他の方向はレベル 1 でも $\theta=2$ で問題ない。
したがって $\Theta_1=10$ が**レベル 1 でも成り立つ**。

**結論（証明された主張）.**

> **系 J6b.** *$\ell=3$、bouquet $(1,0),(0,1),(1,1)$ の塔について、**すべての $n\ge0$** で*
> $$\mathrm{ord}_3(\kappa_n)=5\,(3^{n}-1)-2n. \tag{6.1}$$

**証明.** 上より $\Theta_{M'}=10\cdot3^{M'-1}$（すべての $M'\ge1$）、
$\Sigma_n=10\sum_{M'=1}^n3^{M'-1}=5(3^n-1)$、$\mu=0$、$v_3(\kappa(X))=0$ を $(1.2)$ に入れる。$\blacksquare$

照合（塔の値の独立計算）: $n=0,1,2,3$ で $0,8,36,124$、$(6.1)$ と一致。

**cycle 18 §4.4 が「$M\le3$ の一定性は $M\ge4$ の根拠にならない」と留保した点は解消された。**
系 J5 は**すべての $M$** について一度に結論する。

---

## 7. 取れなかったこと（障害の確定）

### 7.1 打ち消し（$|J(r)|\ge2$）の場合

定理 J4 は $|J(r)|\ge2$ のとき $\theta$ を決めない。決まらないのは
$\sum_{j\in J(r)}\lambda_j\beta_v^{\,j}=0$ となる $\beta_v\in\mathbb{F}_\ell^\times$ に対してだけで、
これは**高々 $\max J(r)$ 個の $\beta_v$**（$\mathbb{F}_\ell$ 上の 1 変数多項式の根）である。
そのときは $\beta$ の次の桁 $\beta_{v+1}$ が効く階層へ降りる必要があり、
本サイクルではその再帰を書いていない。

**具体的な反例**: $\ell=2$ トーラス、$P_0=(1{:}1)$、$r=1$。
$J(1)=\{1,2\}$、$\lambda_1=\lambda_2=1$ で $\beta_0=1$ を入れると $1+1=0$。
$\Lambda(1)=4$ に対し実際は $\theta(1,3)=6$（$\overline{\Phi_{(1,3)}}=x^6(1+x)$ を直接計算）。
**これが「閉形式化を妨げているもの」の 1 つ目であり、反例つきで確定している。**

**奇 $\ell$ でも起きる。** 検証 Step C は次を実測した（いずれも $\bmod\ \ell$ 方向の
整数代表を基点にした場合）。

| $\ell$ | グラフ | 基点 | $e_j$ | $\Lambda$ が一意でない層 |
|---|---|---|---|---|
| 3 | bouquet $(1,0)^2,(0,1)$ | $(1{:}2)$ | $4,1,0$ | 8 層中 6 層 |
| 3 | bouquet $(1,0),(2,3),(1,1)$ | $(1{:}0)$ | $4,1,0,0,0,\infty,0$ | 8 層中 6 層 |
| 5 | bouquet $(1,0)^4,(0,1)$ | $(1{:}4)$ | $6,1,0$ | 4 層すべて |

いずれも「その球の中に $\theta=\infty$ の点が入っているのに、基点をそこに取っていない」場合で、
**基点を $S_\infty$ の点へ取り直すと打ち消しは消える**（$\ell=5$ の例なら $(1{:}4)$ ではなく
$(1{:}-1)$ を基点にする。§5.3）。$\ell=2$ トーラスは基点を取り直しても
2 点が $2$ 進距離 $1/2$ にあるため $r_0=2$ まで下がらないと消えない（§5.4）。
**「基点を適切に取れば必ず消える」とは主張しない**（一般には未解決）。

### 7.2 $\{\theta=\infty\}$ の位相

$\{\theta=\infty\}\subset\mathbb{P}^1(\mathbb{Z}_\ell)$ は閉集合である
（$\theta<\infty$ の点は局所定数性から開近傍を持つ、系 J3）。
§5.3 (1) の族では $S_\infty=\{(1{:}1),(1{:}-1)\}$ と**厳密に決定できた**（有限、2 点）。
一般に $S_\infty$ が有限になるか（たとえば $\mathbb{Z}_\ell$ の Cantor 集合的な
無限閉集合になりうるか）は**決めていない**。無限なら定理 J7 の仮定 (F) が破れ、
計数が破綻するので、これは本質的な未解決点である。
また、$S_\infty$ を有限計算で決める一般的な手続きも書けていない
（$\theta=\infty$ は「$\bmod\ \ell$ で恒等的に消える」という有限桁では確かめられない条件である）。

$\theta=\infty$ の点で $E$ を $\ell$ で割って取り直す段階的処理（$(5.6)$ で 1 段だけ使った）を
一般に何段必要か、という問いは cycle 19 step 2 の対象なので本 step では扱わない。

### 7.3 $\ell=2$

§5.4 の通り、$\ell=2$ では $S_\infty$ の点が $\bmod\ 2$ で分離されないため
定理 J7 の仮定 (N)・(B\*) が破れやすい。$\ell=2$ トーラスでは $b$ だけは当たるが、
$\Theta_{M'}$ の定数項は定理 J7 の計算では出ない（真値 $\Theta_3=44$ に対し
定理 B′ の和は $40$）。**一般の $\ell=2$ 退化塔を扱う道具は無い**
（cycle 18 命題 F の状況と同じだが、理由は違う）。

### 7.4 段数の壁

cycle 16 §8-2 と同じく、塔の値 $\kappa_n$ の独立計算（Matrix-Tree 定理の $\ell^{2n}$ 次行列式）には
到達段数の上限がある。本サイクルの結論は点ごとの付値を証明することで壁を**回避**したのであって、
壁自体は残っている。到達段数は検証ログに全件記載する。

### 7.5 $d\ge3$

$(1.2)$ 自体が $d=2$ の式であり、本サイクルも $d=2$ に限る。

---

## 8. 何が新しく分かったか（cycle 18 との差分）

### 8.1 「$\theta$ を $\mathbb{P}^1(\mathbb{F}_\ell)$ の関数にする」ことをやめた

cycle 18 は $\theta$ が方向の不変量になる条件（$\theta\le\ell$）を探し、
それが破れる場所（$m=\ell+1$）まで突き止めて止まっていた。
本サイクルの視点の変更は、**$\theta$ を最初から $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数と見る**ことである。
すると

- 「$M$ 依存」は病理ではなく、**$\theta$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ ではなく $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数だという当たり前のこと**の言い換えになる。
- 閉形式が出るかどうかは「$\theta$ が方向の関数か」ではなく「**$\theta$ が有限レベルで止まるか**」（系 J3）になる。
- 止まるかどうかはファイバーごとの Newton 多角形（定理 J4）が決め、判定は有限計算（系 J5）。

### 8.2 判定条件の射程（$\theta\le\ell$ より真に広い）

系 J5 は $\theta(P)\le\ell$ を真に含む。母集団走査での内訳は検証ログ Step G2 に出す。
**少なくとも 1 例（§6 の $\ell=3$、$\theta=4>\ell$）で真に広い**ことは証明つきで確定している。

### 8.3 型 III の源が特定された

| | cycle 16 | cycle 17 | cycle 18 | **cycle 19** |
|---|---|---|---|---|
| 型 II の判定条件 | 無し | 無し | $\theta\le\ell$（系 E） | **$\theta$ が有限レベルで止まる**（定理 J6・系 J5） |
| 型 II の実例 | 0 件 | トーラス 1 族 | $\ell\ge5$ で多数 | $\theta\ge\ell+1$ の例も入る（§6） |
| 型 III の実例 | $\ell=2$ トーラス 1 個 | 同左 | 同左 | **奇素数ごとに 1 族（定理 J8）** |
| 型 III の原因 | 不明 | 不明 | 不明（$\theta=\infty$ は「第 3 の破れ方」とだけ） | **$\theta=\infty$ の $\mathbb{Z}_\ell$ 点。係数 $b=\sum_{P\in S_\infty}j^*(P)$**（定理 J7） |

---

## 9. 数値支持どまりのものと、その検出力

**本 report で「証明した」と書いた主張は、すべて有限個の例に依らない証明を本文に持つ。**
数値だけで支えている主張は次の 2 件で、これらは「証明した」とは書かない。

### 9.1 定理 K の適用可能性（最小点の一意性）が母集団で広く成り立つこと

定理 K・定理 J6・定理 J7 はいずれも「$(4.2)$ の最小点が一意」という仮定を持つ。
この仮定が**どのくらいの割合の塔で成り立つか**は、母集団走査（検証ログ Step D）でしか見ていない。

**検出力（明示）**: 母集団は bouquet 2–3 ループと 2 頂点 3 重辺（voltage 9 種）で、
$\ell\in\{2,3,5,7\}$。塔の照合段数は検証ログに全件出す。
標本サイズ $N$ の全走査で破れ 0 件だったとき、**破れ率 $p$ に対する検出力は $1-(1-p)^N$** であり、
$95\%$ の確度で除外できるのは $p\gtrsim3/N$ までである（$N$ の値はログ参照）。
これは「この母集団のこの $\ell$ の範囲で」の話であって、**一般の塔についての主張ではない。**
とくに、母集団の外（$d\ge3$、頂点数の多いグラフ、大きい voltage、大きい $\ell$）で
打ち消しが起きないという主張はしていない。

### 9.2 「基点を $S_\infty$ の点に取り直せば打ち消しは消える」

§7.1 の表で観測した奇 $\ell$ の打ち消しは、いずれも基点を $S_\infty$ の点に取り直すと消えた。
しかし**これが一般に成り立つとは主張しない。** 確かめたのは §7.1 の 3 例と §5.3 の族だけである。
$\lambda_j$ が $\mathbb{F}_\ell$ 上の一般の元である以上、
$|J(r)|\ge2$ かつ $\sum_{j\in J(r)}\lambda_j\beta_v^{\,j}$ の根が $\mathbb{F}_\ell^\times$ に落ちる例は
$S_\infty$ と無関係にも起こりうると考えるのが自然である
（**これは予想であり、根拠は heuristic である**）。

---

## 10. 既知性・新規性

**新規性は主張しない。**

- 定理 J4 は、$\bar E$ を形式群 $\hat{\mathbb{G}}_m$ の 1 径数部分群へ引き戻したときの Newton 多角形であり、
  Iwasawa 理論・$p$ 進 Weierstrass 準備の文脈では標準的な道具である可能性が高い。
  Monsky / Cuoco–Monsky の枠組みで同等の不変量が既に導入されているかは**確認できていない**
  （両論文の本文は cycle 14・16・17・18 と同じく**未取得**）。
- 定理 J2（桁定理）の内容は Lucas の定理の直接の帰結であり、完全に古典的である。
  本 report の寄与があるとすれば、$A_1=0$ による閾値の $+1$ と、
  命題 J2′ の「破れるのは $\bar A_2$ の極形式が非零のとき、かつそのときに限る」だけである。
- 定理 J8 の族は初等的な bouquet であり、その $\kappa_n$ が既知文献にある可能性を排除できていない。
- **文献は abstract だけで「確認した」と書かない**という原則に従い、
  **本 step で新たに本文を確認した文献は無い**（文献調査は本 step の作業に含めていない）。

---

## 11. 自分が途中で犯した誤り（隠さず記録する）

### 11.1 $n\ell^n$ 係数の $\ell$ 倍の取り違え

定理 J7 を最初に導いたとき、$\Theta_{M'}$ の $M'\ell^{M'}$ 係数
$\beta=j^*(1-\ell^{-1})$ から $\Sigma_n$ の $n\ell^n$ 係数への換算で
$\sum_{M'\le n}M'\ell^{M'}$ の主要項を $n\ell^n$ と見て $b=\beta$ と書いた。
正しくは $\frac{\ell}{\ell-1}n\ell^n$ で $b=\beta\cdot\frac{\ell}{\ell-1}=\sum j^*$ である。
**$\ell=5$ の例で手計算した閉形式 $2n5^n+\cdots$（$b=2$）と $\beta=8/5$ が
合わないことに気づいて検出した。** 例を 1 つ通しで計算していなければ見逃していた。

### 11.2 $S_\infty$ を $\mathbb{P}^1(\mathbb{F}_\ell)$ の方向の集合だと思い込んだ（本サイクル最大の誤り）

$(5.2)$ を最初に書いたとき、和を
$\sum_{P_0\in\mathbb{P}^1(\mathbb{F}_\ell),\ \theta(P_0)=\infty}j^*(P_0)$
すなわち **$\bmod\ \ell$ の方向についての和**としていた。$\theta$ を
$\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数として扱うことを §2 でわざわざ強調しておきながら、
$\theta=\infty$ の側では方向へ戻ってしまっていた。

この誤りは 2 つの誤結論を生んだ。

1. **$\ell=2$ トーラスを「定理 J7 の反例」だと結論した。** $\bmod\ 2$ の方向は
   $(1{:}1)$ の 1 本しかないので $\sum j^*=1$、真値 $b=2$ と合わない、と読んだ。
   正しくは $S_\infty=\{(1{:}1),(1{:}-1)\}$ の**2 点**で $\sum j^*=2$ となり**合う**。
   その上で「$j^*\le\ell-2$ が要る」という命題（命題 J7′）まで書いてしまっていた。
   **これは撤回した。** $\ell=2$ が特別なのは $j^*$ の大きさではなく、
   $S_\infty$ の 2 点が $\bmod\ 2$ で分離されないことである（§5.4）。
2. **§5.3 の族で、方向 $(1{:}\ell-1)$ の整数代表 $(1,\ell-1)$ を基点にしていた。**
   検証 Step C が「$\ell=5$、$(1{:}4)$ で $e_0=6$（有限）、$\Lambda$ の $\mathrm{argmin}$ が
   4 層すべてで一意でない」と出したことで気づいた。$\mathbb{Z}_5$ の点として
   $4\neq-1$ であり、$\theta=\infty$ なのは $(1,-1)$ の方である。

**検出のきっかけは、うまくいった例ではなく「合わない例」と「検証が吐いた見慣れない出力」だった。**
Step C に $\mathrm{argmin}$ が一意でない件数を出力させていなければ 2 は見つかっていない
（cycle 18 注 2.2 と同じ教訓）。

### 11.3 検証の間引き幅を $\ell$ の倍数に取って、破れを検出できなくした

Step A の $L=2,3$ は全列挙が重いので $(a,b)$ を等間隔に間引いたが、
最初その間隔を $\ell$ に取った。すると標本の $(a,b)$ がすべて $(0,0)\bmod\ell$ になり、
破れを与える双一次形式 $\bar B((a,b),(u,v))$（命題 J2′）が標本上で恒等的に消え、
**破れ 0 件**という出力になった。これは「破れが正であること」を要求する検査
（cycle 18 注 2.2 の教訓）が拾ってくれた。間隔を $\ell$ と互いに素に取り直して解消した。
**検査を「0 件で合格」に書いていたら、間引きの設計ミスを見逃していた。**

### 11.4 $\theta$ と $\hat\theta$ の混同

当初は cycle 18 §4.3 の表の値を $\theta$ の実測だと読んでいたが、
表が測っているのは $\hat\theta=\varphi(\ell^M)v_\ell(E)$ であり、
定理 B の条件が破れる点では $\theta$ と一致しない（注 4.2 のとおり常に $\hat\theta\le\theta$）。
$(1.3)$ で記号を分けたのはこのためである。
cycle 17 で記号の混同が 10 サイクル見逃されて命題 B が偽になった事故と同じ型の危険だった。

---

## 12. 敵対的レビュー（自分の結論を反証しにいった記録）

1. **「定理 K の予言は塔の値へのフィットではないか」** → 違う。$(4.3)$ の右辺で塔の値を使うのは
   $v_\ell(\kappa(X))$（$n=0$ の底グラフ、1 個の整数）だけで、$n\ge1$ の予言は $D$ の係数から出る。
   検証の全段が out-of-sample。フィットで係数を解いた箇所は本 report に無い。
2. **「定理 J6 は cycle 18 定理 C の言い換えにすぎないのではないか」** → 違う。
   §6 の $\ell=3$ の例は $\theta=4>\ell=3$ で定理 C の仮定を満たさないが定理 J6 は適用でき、
   しかも cycle 18 が「数値支持どまり」と書いた式を証明する。
3. **「系 J5 の判定条件は空でないか（$\theta>\ell$ で通る例があるか）」** → ある（§6）。
   母集団での件数は検証ログ Step G2。
4. **「$\theta=\infty$ が $n\ell^n$ を生むというのは、たまたま合っただけではないか」**
   → 定理 J7 に証明がある。族は $\ell=3,5,7,11$ の 4 つで塔の値と照合した。
   さらに、**仮定が破れる $\ell=2$ トーラスでは $b$ は当たるが $\Theta_{M'}$ の定数項が外れる**
   ことを確かめた（§5.4。真値 $\Theta_3=44$ に対し定理 B′ の和は $40$）。
   仮定が効いている場所を具体的に押さえられている。
4′. **「$(5.2)$ の和は方向についてか、$\mathbb{Z}_\ell$ の点についてか」** → $\mathbb{Z}_\ell$ の点である。
   最初は方向だと思い込んで誤った結論を出した（§11.2）。検証は両方を出力して差を見せている。
5. **「定理 J2 の閾値 $m\le\ell^L$ は本当に鋭いか（$m=\ell^L+1$ で本当に破れるか）」**
   → 命題 J2′ が必要十分条件を与える。検証は破れの**件数が正である**ことを要求する形に書いた
   （cycle 18 注 2.2 の教訓。0 件で満足すると誤った閾値を見逃す）。
   ただし $\ell=2$ の検証例では破れ 0 件で、これは命題 J2′ の
   「$\bar A_2$ が平方なら破れない」の帰結である（検証不足ではない）。
6. **「補題 J1 は cycle 16 定理 D1 の使い回しだが、$\mathbb{P}^1(\mathbb{Z}/\ell^{M'})$ で数え直して正しいか」**
   → 正しい。軌道の大きさ $\varphi(\ell^{M'})$ と点の総数 $\ell^{2M'}-\ell^{2M'-2}$ の
   検算を本文に書いた。検証では個数と値の両方を全列挙で照合している。
7. **「$\theta$ を $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数と見るのは、非可算集合への不用意な脱出ではないか」**
   → 違う。§4.4 の通り、実際に使うのは有限レベル $\mathbb{P}^1(\mathbb{Z}/\ell^L)$ への還元と
   コンパクト性（有限被覆の存在）だけで、$\mathbb{R}$ も非可算集合の個別の元も使っていない。
   なお系 J3 の証明でコンパクト性を使う点は、逆数学的には $\mathbb{Z}_\ell$ の全有界性に依るので
   $\mathrm{WKL}_0$ 程度で足りると思われるが、**これは確認していない**。
8. **「定理 J8 の族は $\ell$ ごとにグラフが変わるので、1 個の塔の結果を並べただけではないか」**
   → そうではない。証明は $\ell$ を固定せずに一様に行っており、$(5.3)$ の右辺は $\ell$ に依らない形をしている。
   ただし「奇素数ごとに 1 族」であって「すべての退化塔」ではない（§7 の限界）。

---

## 13. 検証コード

`sagemath/check/cycle19_T3_theta_ge_ell/`（README.md に対象・手順・限界、
RESULTS.md に実行結果、`_defs19.sage` / `theta_padic.sage` / `theta_padic.out`）。

- **Step A**: 定理 J2 を $L=1,2$ で全列挙照合し、$m=\ell^L+1$ での破れの件数を出す。
  命題 J2′ の必要十分条件（$\bar A_2$ の極形式）と突き合わせる。
- **Step B**: 定理 B′ を、$\mathbb{Q}(\zeta_{\ell^M})$ での付値の**独立計算**と照合。
  最小点が一意でない点は「予言は下界」として分けて扱う。
- **Step C**: 定理 J4 を、$\theta$ の直接計算（$\overline{\Phi}$ の位数）と照合。
  $|J(r)|\ge2$（打ち消しうる）件数も出す。
- **Step D**: 定理 K を母集団全走査で、Matrix-Tree 定理による塔の値と照合（フィット 0 個）。
- **Step E**: §6（系 J6b）。ファイバー上の $\theta$ 一定性をレベル 4 まで全列挙、
  $\Theta_{M'}=10\cdot3^{M'-1}$、塔の値 $5(3^n-1)-2n$ を照合。
- **Step F**: 定理 J8（$\ell=3,5,7$）と、$\ell=2$ トーラスが反例であること。
- **Step G**: 敵対的レビュー（§12 の 1・3・4・5 に対応）。

**Step A–F は証明済み命題の照合である。§9 の 2 件だけが数値支持どまりであり、本文にもそう書いた。**

### 計算の打ち切りについて

塔の値の計算（$\ell^{2n}$ 次の行列式）と円分体での付値計算は、深いところでは現実的な時間で終わらない。
各段に時間上限を設け、**打ち切った計算はログ末尾の一覧に全件出力**して結論の射程外に置く。
到達範囲は `RESULTS.md` に記す。
