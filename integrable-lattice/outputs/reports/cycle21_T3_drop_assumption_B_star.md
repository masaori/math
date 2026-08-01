# cycle 21 / T3 Pure: 定理 J7 の最後の仮定 (B\*) を落とす

対象: cycle 20 step 2（`outputs/reports/cycle20_T3_s_infinity_decision.md`）§8.1 が
**「取れなかったこと（障害の確定）」**として残した箇所 —

> 系 W6 は定理 J7 の (B\*) を引き継ぐ。**(B\*) は実際に破れる。**（反例 2 件）
> **本 step の道具（$\bmod\ \ell$ の因数分解）は原理的にそこへ届かない。**

を埋める。すなわち **$n\ell^n$ の係数 $b=\sum_{P\in S_\infty}j^*(P)=\sum_i m_i$ を、
仮定 (F)・(N)・(B\*) をすべて外して証明する**のが本 step である。

前提として読んでいる一次情報:
`cycle19_T3_theta_ge_ell_plus_1.md`（以下 **step 1(19)**。補題 J0、定理 J2、定理 J4、補題 J1、
定理 B′、定理 J6、定理 J7、補題 J9、系 J10、§5.4、§7）、
`cycle19_T3_theta_infinity.md`（命題 2、命題 3、定理 X′、§9.1）、
`cycle20_T3_cancellation_recursion.md`（定理 L1、系 L3′、**定理 L4**、定理 K′、§8.3）、
`cycle20_T3_s_infinity_decision.md`（定理 W1、補題 W2、定理 W3、**定理 W4**、系 W5、系 W6、§8.1）、
`cycle20_T3_ell_equals_2.md`（定理 Y′、§6.3）、
`cycle16_T1_monsky_primary_sources.md`（**Cuoco–Monsky 原文の書き写し** §3.2）、
`cycle18_T1_monsky1989_acquisition.md`（Monsky 1989 の本文照合）。

記号は step 1(19) §1 を引き継ぐ。本 report で新たに導入する命題には **Q** を冠する。

---

## 0. 結論（先に置く）

| 主張 | 状態 |
|---|---|
| **定理 Q1（無条件の $n\ell^n$ 係数）**: 仮定 (H) だけの下で $$\bigl|\Theta_M-b\,M\,\varphi(\ell^M)\bigr|\le C\,\ell^M,\qquad b=\sum_i m_i$$ が**$M$ に依らない明示定数 $C=b(3+r\ell^{c_1})+\theta_G^{\max}\frac{\ell+1}{\ell}+r\ell^{c_1}\log_\ell C_0$ つき**で成り立ち、したがって $\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+b\,n\ell^n+O(\ell^n)$。**仮定 (F)・(N)・(B\*) はいずれも不要** | **証明した**（§6）。**これが本 step の答えである: (B\*) は落ちる** |
| **補題 Q1′（整数のままの分解）**: $\tilde E=B\,G+\ell H$（$B=\prod_i(\chi^{v_i}-1)^{m_i}$、$G,H\in\mathbb{Z}[z^{\pm},w^{\pm}]$、$\bar G$ は原始二項式因子を持たない） | **証明した**（§3.1）。$\bmod\ \ell$ の因数分解を**整数へ持ち上げる**のが本 step の唯一の新しい着想である |
| **補題 Q2（$G$ 側は一様に浅い）**: $\theta_G$ は $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上で至る所有限、したがって有界。さらに $\varphi(\ell^M)>\theta_G^{\max}$ なら**全点で** $v_{\mathfrak l}(G(\omega_P))=\theta_G(P)$ | **証明した**（§3.2）。ここに (B\*) 型の仮定は要らない（$\varphi(\ell^M)$ が勝手に大きくなるから） |
| **定理 Q4（点ごとの等号）**: $\beta_P+\theta_G^{\max}<\varphi(\ell^M)$ なる点では $$\hat\theta_M(P)=\beta_P+\theta_G(P),\qquad \beta_P=\sum_i m_i\,\ell^{\rho_i(P)}$$ が**等号で**成り立つ | **証明した**（§4）。実測 **17781 点で不一致 0 件** |
| **補題 Q5（悪い点は $O(1)$ 個）**: 上の条件を満たさない点の個数は $M$ に依らず $r\ell^{c_1}$ 以下（$c_1$ は明示） | **証明した**（§5.2）。実測でも $M$ について有界（§8） |
| **補題 Q0（粗上界）**: $\hat\theta_M(P)\le\varphi(\ell^M)\log_\ell C_0$（$C_0=\sum|c_{pq}|$） | **証明した**（§5.1）。**本 report で $\mathbb{R}$（アルキメデス素点）へ脱出する唯一の箇所**。§7.3 で隔離を明示する |
| **補題 Q3（数え上げ）**: $\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^M)}\ell^{\rho_v(P)}=(M-1)\varphi(\ell^M)+2\ell^M$ | **証明した**（§5.3）。**最初に書いた式は誤っていた**（§10.1） |
| **(B\*) は何を保証していたのか** | **確定した**（§7）。(B\*) は「**最内側の $O(1)$ 個の点での付値の正確さ**」を保証していた。$b$（$n\ell^n$）には効かないが、$c$（$\ell^n$）以降には効く。実測でも **(B\*) の破れは 143 点すべてが「悪い点」で起き、「良い点」では 1 件も起きていない** |
| **cycle 20 §7.2 (a) の「(B\*) が破れても $b$ は当たる」（標本 13 組・破れ率 23% までしか除外できない予想）** | **定理に格上げされた**（定理 Q1）。数値支持ではなくなった |
| **$\ell=2$ トーラスの $b=2$**（step 1(19) §5.4 が「照合であって証明ではない」と書いた箇所） | **証明された**（定理 Q1 は $\ell=2$ を除外しない）。cycle 16 定理 D2 の別証明にもなっている |
| $\ell^n$・$n$・定数の係数（$c,d,e$） | **取れていない**（§9.2）。定理 Q1 の誤差項 $O(\ell^M)$ の中身は本 step では開けていない |
| **既知性** | **既知である。新規性は主張しない**（§11）。定理 Q1 は **Cuoco–Monsky (Math. Ann. 255 (1981), 235–258) Theorem 1.7 ＋ Definition 1.2** そのものであり、$b$ は彼らの $l_0(F)$ に一致する。**この同定が本 step のもう 1 つの成果である** |

**「証明した」と書いたものは、すべて有限個の例に依らない証明が本文にある。
数値支持どまりのものは §9 に隔離し、標本サイズから何が言えるかを明記した。**

### 訂正履歴（後のサイクルが検出した問題。隠さず残す）

| 日付 | 箇所 | 訂正 | 検出したのは |
|---|---|---|---|
| 2026-08-01（cycle 23 step 1） | 定理 Q1 $(6.1)$ | 「明示定数 $C$」の中に $\lvert\mathcal{B}_M\rvert$（レベル $M$ ごとの実測値）が入っており、**$M$ に依存していた**。補題 Q5 の上界 $r\ell^{c_1}$ を代入し、$M$ 非依存な形に直した | cycle 22 step 4 |
| 2026-08-01（cycle 23 step 1） | 定理 Q1 の証明 | $\mathcal{B}_M$ 上でも $\tilde E(\omega_P)\neq0$（＝補題 Q0 が使える）ことを明示した。(H) から従うので誤りではないが、依存が読めなかった | 同上 |
| 2026-08-01（cycle 23 step 1） | 補題 Q5 の証明 | $c_1$ の定義の $+1$ が**狭義**不等式 $2b<(\ell-1)\ell^{c_1}$ を作るために要ることを、非狭義では偽になる反例つきで書き足した | 同上 |

**いずれも定理 Q1 の結論 $(6.2)$ と §8 の照合結果を変えない**（上界を緩める・依存を明示する・
根拠を書き足す方向の訂正である）。

検証は 3 本のスクリプトに分割し、**いずれも壁時計 20 秒以内で完走した**（設計上限 20 分の内側。
cycle 19・20 で 3 回起きた「掃引起動直後にセッションが終了」への対策）。**FAIL 0 件・打ち切り 0 件。**

---

## 1. 設定

$X$ は有限連結 voltage 多重グラフ、$\alpha:E\to\mathbb{Z}^2$、$L(z,w)$ は voltage ラプラシアン、
$D=\det L\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$、$\mu=v_\ell(\mathrm{content}_{z,w}D)$、$E=\ell^{-\mu}D$、
$\tilde E=z^rw^sE=\sum_{(p,q)}c_{pq}z^pw^q\in\mathbb{Z}[z,w]$、$\kappa_n=\kappa(X_{\ell^n,\ell^n})$。
仮定 **(H)** を通して置く（$X_{\ell^n,\ell^n}$ が全ての $n$ で連結。同値な形は cycle 18 系 C2′）。
$\bar{\ }$ は $\bmod\ \ell$。$E=\ell^{-\mu}D$ の取り方から $\bar{\tilde E}\neq0$ である。

$K_M=\mathbb{Q}(\zeta_{\ell^M})$、$\mathfrak{l}$ は $\ell$ の上の唯一の素点、
$v_{\mathfrak{l}}$ は $v_{\mathfrak{l}}(\ell)=\varphi(\ell^M)$ と正規化する（$\ell$ は完全分岐、$f=1$）。
$P=(a{:}b)\in\mathbb{P}^1(\mathbb{Z}/\ell^M)$ に対し $\omega_P$ を指標 $z\mapsto\zeta^a,\ w\mapsto\zeta^b$（$\zeta$ は原始 $\ell^M$ 乗根）とし

$$\hat\theta_M(P):=v_{\mathfrak{l}}\bigl(\tilde E(\omega_P)\bigr)\in\mathbb{Z}_{\ge0}
\qquad(\text{step 1(19) }(1.3)\text{ と同じ量}),$$

$$\Theta_M:=\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^{M})}\hat\theta_M(P),\qquad
\Sigma_n=\sum_{M=1}^n\Theta_M \quad(\text{補題 J1。仮定なしに成立}),$$

$$\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa(X))-2n+\mu(\ell^{2n}-1)+\Sigma_n \tag{1.1}$$

（cycle 14 $(6.1)$）。$\chi^{(p,q)}:=z^pw^q$ と書く。

cycle 20 $(4.1)$ より、$\mathbb{F}_\ell[z^{\pm1},w^{\pm1}]$（UFD）で

$$\bar{\tilde E}=c\,\chi^{w_0}\prod_{i=1}^{r}\bigl(\chi^{v_i}-1\bigr)^{m_i}\cdot\bar G_0,
\qquad c\in\mathbb{F}_\ell^\times,\ \ (\chi^{v}-1)\nmid\bar G_0\ (\forall v\ \text{原始}) \tag{1.2}$$

が一意に定まり（$v_i$ は原始ベクトル、$\pm$ 同一視）、cycle 20 定理 W1・W4 により
$S_\infty=\{\iota([v_i^\perp])\}$、$j^*(\iota([v_i^\perp]))=m_i$、したがって

$$b:=\sum_{i=1}^{r}m_i=\sum_{P\in S_\infty}j^*(P). \tag{1.3}$$

**本 report が示すのは、$(1.3)$ の $b$ が $\mathrm{ord}_\ell(\kappa_n)$ の $n\ell^n$ 係数であることを
仮定なしに言えること**である。$(1.3)$ 自体（$S_\infty$ の決定・$j^*$＝重複度）は cycle 20 で
すでに無仮定で証明されている。

---

## 2. 何が問題だったのか

定理 J7（step 1(19) §5.2）の証明は、$\hat\theta_M(P)$ を **$\theta(P)$（$\bmod\ \ell$ の消滅位数）で
置き換える**ことから出発していた。その置き換えを保証するのが定理 B′ であり、

> **(B\*)** ある $n_1$ が存在して、レベル $M\ge n_1$ のすべての点で
> $\min_m\bigl(\varphi(\ell^M)v_\ell(A_m)+m\bigr)$ の最小点が一意である

が要る。cycle 20 §8.1 が確定させたとおり **(B\*) は実際に破れる**:

- **反例 1**（$\ell=2$ トーラス）: $M=3$ の点 $(1{:}3)$ で $\Lambda=6$ に対し実測 $8$。
- **反例 2**（$\ell=3$、bouquet $(1,0),(0,1),(1,1),(1,-1)$、$b=4$）: $M=2$ の層で $\Lambda=8$ に対し実測 $12$。

cycle 20 §8.1 は妨げをこう具体化していた:

> 定理 W4 は $\bar{\tilde E}$ の**二項式因子**を制御するが、$\Phi_{(a,b)}$ の**係数の $\ell$ 付値の列**は
> 制御していない。**本 step の道具（$\bmod\ \ell$ の因数分解）は原理的にそこへ届かない**
> （$\bmod\ \ell$ で消える情報だから）。

**この診断は正しい。そして、だからこそ回り道が要る。**
本 step の着想は「$\bmod\ \ell$ の因数分解を $v_\ell(A_m)$ の列へ届かせる」のではなく、
**$\theta$ を経由するのをやめて $\hat\theta_M$ を直接評価する**ことである。
そのために $(1.2)$ の因数分解を **整数へ持ち上げて** $\tilde E=BG+\ell H$ と書く。
すると $\hat\theta_M(P)$ は 2 項の付値の比較になり、比較が拮抗する点（＝ (B\*) が破れる点）は
**レベルごとに $O(1)$ 個しかない**ことが数え上げで分かる。$O(1)$ 個の点は $O(\ell^M)$ しか動かせないので
$M\ell^M$ の係数には効かない。これが定理 Q1 の骨格である。

> **課題設定との関係（正直に書く）**: 本 step の指示は「**定理 L4（終結式）は最小点が同点でも
> 値を出すので、終結式の側から $\Theta_M$ を評価すれば仮定なしで $b$ が出る可能性がある**」であった。
> 結果としてはそのとおりになったが、**効いたのは終結式そのものではない**。
> 定理 L4 は (a) 検証で $\hat\theta_M$ を理論から独立に厳密計算する道具として、
> (b) 補題 Q0（アルキメデス粗上界）を $v_\ell(\mathrm{Res})$ の形で書くために使っただけで、
> 証明の骨格を作ったのは**整数への持ち上げ $\tilde E=BG+\ell H$** である。
> 「終結式から攻める」という指示の筋は、正確には「**$\theta$ を経由せず $\hat\theta$ を直接見る**」
> という筋だった。

---

## 3. 整数のままの分解

### 3.1 補題 Q1′（分解）

> **補題 Q1′.** *$(1.2)$ の記号で $B:=\prod_{i=1}^r\bigl(\chi^{v_i}-1\bigr)^{m_i}\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$
> と置く（$v_i$ は整数ベクトルなので $B$ は整数係数である）。$\bar{\tilde E}/\bar B\in\mathbb{F}_\ell[z^{\pm1},w^{\pm1}]$
> の任意の持ち上げ $G\in\mathbb{Z}[z^{\pm1},w^{\pm1}]$ を取ると*
> $$H:=\frac{\tilde E-B\,G}{\ell}\in\mathbb{Z}[z^{\pm1},w^{\pm1}] \tag{3.1}$$
> *であり、$\bar G$ は原始二項式因子 $\chi^v-1$ をひとつも持たない。*

**証明.** $\bar B\bar G=\bar{\tilde E}$ なので $\tilde E-BG$ の全係数が $\ell$ で割れる。
$\bar G=c\chi^{w_0}\bar G_0$ で、$(1.2)$ の一意性から $\bar G_0$ は $\chi^v-1$ 型の因子を持たない。
単項式 $\chi^{w_0}$ と単元 $c$ は素元 $\chi^v-1$ で割れないので $\bar G$ も持たない。$\blacksquare$

**この 1 行が本 step の全てである。** cycle 20 は $(1.2)$ を $\mathbb{F}_\ell$ の中だけで使っていた。
$B$ の側は**整数のまま持ち上がる**（二項式の係数が $\pm1$ だから）ので、
$\ell$ 進付値の議論へそのまま持ち込める。持ち上がらないのは $\bar G_0$ の側だが、
そちらは $\ell H$ の誤差として $\varphi(\ell^M)$ 以上の付値に押し込める。

### 3.2 補題 Q2（$G$ 側は一様に浅い）

> **補題 Q2.** *(1) $\theta_G(P)<\infty$ が全ての $P\in\mathbb{P}^1(\mathbb{Z}_\ell)$ で成り立つ。
> したがって $\theta_G$ は有界であり、最大値を $\theta_G^{\max}$ と書く。
> (2) $\varphi(\ell^M)>\theta_G^{\max}$ なるレベル $M$ の**すべての**点 $P$ で*
> $$v_{\mathfrak{l}}\bigl(G(\omega_P)\bigr)=\theta_G(P)\ \ (<\infty). \tag{3.2}$$

ここで $\theta_G(P):=\mathrm{ord}_{x=0}\overline{\Phi^G_{(a,b)}}$、$\Phi^G_{(a,b)}(x)=\tilde G((1+x)^a,(1+x)^b)$、
$\tilde G$ は $G$ に単項式を掛けて多項式にしたもの（単項式は 1 の冪根＝単元なので付値に影響しない）。

**証明.** **(1)** 補題 W2（3⇔1）は $\bar{\tilde E}$ に固有の性質を使っていない: 任意の
$0\neq\bar F\in\mathbb{F}_\ell[z^{\pm},w^{\pm}]$ と原始整数ベクトル $u$ について
$\theta_F(u)=\infty\iff(\chi^{u^\perp}-1)\mid\bar F$ である（証明は $\ker\bar\psi_u=(\chi^{u^\perp}-1)$ のみを使う）。
補題 Q1′ より $\bar G$ にそのような因子は無いので、有理点では $\theta_G<\infty$。
無理点（$\mathbb{P}^1(\mathbb{Z}_\ell)\setminus\mathbb{P}^1(\mathbb{Q})$）については系 J10 の証明が
そのまま $\bar G$ に適用でき（使うのは補題 J9 の一次独立性だけ）、$\theta_G=\infty$ なら $P$ は有理点。
よって至る所有限。有界性は補題 J0（局所定数性）と $\mathbb{P}^1(\mathbb{Z}_\ell)$ のコンパクト性（系 J3）。

**(2)** $\Phi^G=\sum_m A^G_mx^m$ とすると $v_{\mathfrak{l}}(A^G_m\pi^m)=\varphi(\ell^M)v_\ell(A^G_m)+m$
（$\pi=\zeta-1$）。$m<\theta_G(P)$ では $\ell\mid A^G_m$ なので値は $\ge\varphi(\ell^M)>\theta_G^{\max}\ge\theta_G(P)$。
$m=\theta_G(P)$ では値はちょうど $\theta_G(P)$。$m>\theta_G(P)$ では値は $>\theta_G(P)$。
**したがって最小点は $m=\theta_G(P)$ で一意**であり、非アルキメデス的評価より $(3.2)$。$\blacksquare$

> **注 3.1（ここが (B\*) と違うところ）.** $(3.2)$ は定理 B′ と同じ形の主張だが、
> **仮定ではなく定理である**。理由は「$\theta_G$ が $M$ に依らず有界で、$\varphi(\ell^M)$ は
> $M$ とともにいくらでも大きくなる」から。$\tilde E$ について同じことが言えないのは
> $\theta_{\tilde E}$ が $S_\infty$ の近傍で $\ell^{r}$ のオーダーまで深くなり、
> $\varphi(\ell^M)$ と競合するからである。**$B$ を括り出すと、深さは全部 $B$ の側へ移り、
> $G$ の側は一様に浅くなる。** これが分解の効き目である。

**実測**: 母集団 461 組すべてで $\bar G$ に二項式因子が残らないことを代数的に確認し、
$\theta_G^{\max}$ を測った（分布 $0{:}133,\ 2{:}181,\ 3{:}1,\ 4{:}104,\ 5{:}7,\ 6{:}32,\ 7{:}3$。
**最大 7**）。検証 Step A/B（`q1_decomposition.out`）。

---

## 4. 定理 Q4（点ごとの等号）

$P=(a{:}b)\in\mathbb{P}^1(\mathbb{Z}/\ell^M)$（$(a,b)$ は原始）に対し

$$\rho_i(P):=\min\Bigl(v_\ell\bigl(\langle v_i,(a,b)\rangle\bigr),\ M\Bigr)\in\{0,1,\dots,M\},
\qquad \beta_P:=\sum_{i=1}^{r}m_i\,\ell^{\rho_i(P)} \tag{4.1}$$

と置く（$\langle\cdot,\cdot\rangle$ は標準内積）。

> **補題 Q4a.** *全ての $\rho_i(P)<M$ ならば $B(\omega_P)\neq0$ かつ $v_{\mathfrak{l}}(B(\omega_P))=\beta_P$。
> ある $i$ で $\rho_i(P)=M$ ならば $B(\omega_P)=0$。*

**証明.** $\chi^{v_i}(\omega_P)=\zeta^{\langle v_i,(a,b)\rangle}$。$\rho:=\rho_i(P)<M$ なら
これは原始 $\ell^{M-\rho}$ 乗根なので
$v_{\mathfrak{l}}(\zeta_{\ell^{M-\rho}}-1)=\varphi(\ell^M)/\varphi(\ell^{M-\rho})=\ell^{\rho}$。
$\rho_i=M$ なら $\chi^{v_i}(\omega_P)=1$ で因子が $0$。$\blacksquare$

> **定理 Q4.** *$\varphi(\ell^M)>\theta_G^{\max}$ とする。点 $P$ が*
> $$\beta_P+\theta_G^{\max}<\varphi(\ell^M) \tag{4.2}$$
> *を満たすならば（とくに全ての $\rho_i(P)<M$）、*
> $$\hat\theta_M(P)=\beta_P+\theta_G(P) \tag{4.3}$$
> *が**等号で**成り立つ。*

**証明.** 補題 Q1′ の分解を $\omega_P$ で評価する:
$\tilde E(\omega_P)=B(\omega_P)G(\omega_P)+\ell\,H(\omega_P)$。
補題 Q4a と補題 Q2 (2) より第 1 項の付値は $\beta_P+\theta_G(P)$（有限）。
第 2 項の付値は $\varphi(\ell^M)+v_{\mathfrak{l}}(H(\omega_P))\ge\varphi(\ell^M)$（$H(\omega_P)=0$ なら $+\infty$）。
$(4.2)$ より $\beta_P+\theta_G(P)\le\beta_P+\theta_G^{\max}<\varphi(\ell^M)$ で**狭義**に小さいから、
非アルキメデス的評価により和の付値は小さい方に一致する。$\blacksquare$

**$(4.3)$ には (B\*) も (N) も (F) も入っていない。** 使ったのは補題 Q1′ の分解と、
補題 Q2 の「$G$ 側が一様に浅い」ことだけである。

**実測**: 18 塔 × $\ell\in\{2,3,5,7\}$ × レベルの掃引で、$(4.2)$ を満たす点 **17781 点**すべてで
$(4.3)$ が**等号で成り立った（不一致 0 件）**。$\hat\theta_M$ は定理 L4 の終結式による厳密計算で、
本 report の理論から独立である。検証 Step F（`q2_pointwise.out`）。

---

## 5. 残りの点と数え上げ

### 5.1 補題 Q0（粗上界。$\mathbb{R}$ へ脱出する唯一の箇所）

> **補題 Q0.** *$\tilde E(\omega_P)\neq0$ ならば*
> $$\hat\theta_M(P)\ \le\ \varphi(\ell^M)\,\log_\ell C_0,\qquad C_0:=\sum_{(p,q)}|c_{pq}|. \tag{5.1}$$

**証明.** 定理 L4 より $\hat\theta_M(P)=v_\ell\bigl(N_{K_M/\mathbb{Q}}(\tilde E(\omega_P))\bigr)$、
右辺は $0$ でない整数 $N$ の $\ell$ 進付値である。$N=\prod_\sigma\sigma\bigl(\tilde E(\omega_P)\bigr)$ で、
各共役は $\sum_{(p,q)}c_{pq}\zeta^{k_{pq}}$（$\zeta$ は 1 の冪根）の形だから
**複素絶対値**は $\le C_0$。よって $|N|\le C_0^{\varphi(\ell^M)}$。
$|N|\ge1$ なので $v_\ell(N)\le\log_\ell|N|\le\varphi(\ell^M)\log_\ell C_0$。$\blacksquare$

> **【$\mathbb{R}$ 脱出の明示】** 上の証明は $\mathbb{C}$ の絶対値（アルキメデス素点）を使う。
> **本 report で非可算の世界へ出るのはここだけである。** 出る理由と隔離のされ方は §7.3 に書く。
> 結論の値 $b$ 自体は $\mathbb{F}_\ell[z,w]$ の因数分解という完全に可算・決定可能な量であり、
> $(5.1)$ が使われるのは**レベルごとに $O(1)$ 個の点の誤差項を押さえるためだけ**である。

**実測**: 1518 点で $(5.1)$ の破れ 0 件。最悪比 $\hat\theta_M/\varphi(\ell^M)=4.0000$ に対し
上界 $\log_\ell C_0=4.3219$（$\ell=2$、$C_0=20$）。検証 Step E。

### 5.2 補題 Q5（悪い点は $M$ に依らず $O(1)$ 個）

$\mathcal{B}_M:=\{P\in\mathbb{P}^1(\mathbb{Z}/\ell^M):\beta_P+\theta_G^{\max}\ge\varphi(\ell^M)\}$ と置く。

> **補題 Q5.** *$\varphi(\ell^M)\ge2\theta_G^{\max}$ かつ $M>c_1$ とすると*
> $$|\mathcal{B}_M|\ \le\ r\,\ell^{c_1},\qquad
> c_1:=\max\Bigl(0,\ \Bigl\lceil 1+\log_\ell\frac{2b}{\ell-1}\Bigr\rceil\Bigr). \tag{5.2}$$
> *とくに $|\mathcal{B}_M|$ は $M$ に依らない。*

**証明.** $P\in\mathcal{B}_M$ なら $\beta_P\ge\varphi(\ell^M)-\theta_G^{\max}\ge\varphi(\ell^M)/2$。
$\rho_{\max}:=\max_i\rho_i(P)$ とすると $\beta_P\le b\,\ell^{\rho_{\max}}$ なので
$\ell^{\rho_{\max}}\ge\varphi(\ell^M)/(2b)=\ell^{M-1}(\ell-1)/(2b)$、すなわち
$\rho_{\max}\ge M-1-\log_\ell\bigl(2b/(\ell-1)\bigr)\ge M-c_1$。

> **$c_1$ の定義の $+1$ が何をしているか（cycle 23 step 1 で書き足した。初稿は理由を書いていなかった）.**
> 最後の $\ge M-c_1$ に効いているのは**狭義**不等式 $2b<(\ell-1)\ell^{c_1}$ である。
> 非狭義 $2b\le(\ell-1)\ell^{c_1}$ では含意が偽になる。反例:
> $\ell=2$, $b=1$, $c_1=1$, $M=3$, $\rho_{\max}=1$ のとき
> $2b\,\ell^{\rho_{\max}}=4=(\ell-1)\ell^{M-1}$ で前提は満たされるが、
> $M-c_1=2>1=\rho_{\max}$ で結論が破れる。このとき $2b=2=(\ell-1)\ell^{c_1}$ と**等号**である。
> $\bigl\lceil\log_\ell\frac{2b}{\ell-1}\bigr\rceil$ だけでは $\frac{2b}{\ell-1}$ が $\ell$ の冪ちょうどのときに
> この等号が起きるので、**$c_1$ の定義の $+1$ はそれを避けるために入っている。**
> **この根拠が書かれていないことは cycle 22 step 4（`cycle22_ops_lean_cycle21_theorems.md` §3.1、
> Lean の `lemma_Q5_rho_max` / `lemma_Q5_needs_strict`）が指摘した。**
したがって $\mathcal{B}_M\subseteq\bigcup_{i=1}^r\{P:\rho_i(P)\ge M-c_1\}$。
$\rho\ge1$ に対し $\{P:\rho_i(P)\ge\rho\}$ は $\mathbb{P}^1(\mathbb{Z}/\ell^M)\to\mathbb{P}^1(\mathbb{Z}/\ell^{\rho})$ の
1 点のファイバーで、大きさは $\ell^{M-\rho}$。$\rho=M-c_1$ とすれば $\ell^{c_1}$。$\blacksquare$

**これが (B\*) の破れを飲み込む機構である。** (B\*) が破れるのは $B$ 側の付値 $\beta_P$ が
$\ell H$ 側の $\varphi(\ell^M)$ と拮抗する点、すなわち $S_\infty$ の点の**最内側の球**である。
$(5.2)$ はそこが $M$ に依らず有限個だと言っている。

### 5.3 補題 Q3（数え上げ）

> **補題 Q3.** *原始整数ベクトル $v$ と $M\ge1$ について*
> $$\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^M)}\ell^{\rho_v(P)}=(M-1)\,\varphi(\ell^M)+2\,\ell^M. \tag{5.3}$$

**証明.** $\#\{P:\rho_v(P)\ge\rho\}=\ell^{M-\rho}$（$1\le\rho\le M$）、$\#\{\text{全体}\}=(\ell+1)\ell^{M-1}$。
よって $\#\{\rho_v=0\}=(\ell+1)\ell^{M-1}-\ell^{M-1}=\ell^M$、
$\#\{\rho_v=\rho\}=\varphi(\ell^{M-\rho})$（$1\le\rho\le M-1$）、$\#\{\rho_v=M\}=1$。
$\varphi(\ell^{M-\rho})\ell^{\rho}=\varphi(\ell^M)$（$1\le\rho\le M-1$、$M-1$ 個）なので

$$\sum_P\ell^{\rho_v(P)}=\ell^M\cdot1+(M-1)\varphi(\ell^M)+1\cdot\ell^M
=(M-1)\varphi(\ell^M)+2\ell^M.\qquad\blacksquare$$

**実測**: $(\ell,M,v)$ の 108 組で破れ 0 件（検証 Step D）。
**最初に書いた式 $M\varphi(\ell^M)+\ell^M$ は誤りだった**（$\rho=0$ の層の個数を $\varphi(\ell^M)$ と
数えていた。$\mathbb{P}^1$ の点数は $\ell^M$ ではなく $(\ell+1)\ell^{M-1}$ である）。§10.1 に記録する。
**主要項 $M\varphi(\ell^M)$ は変わらないので定理 Q1 の結論には影響しない。**

---

## 6. 定理 Q1（主定理）

> **定理 Q1.** *仮定 (H) の下、$\varphi(\ell^M)\ge2\theta_G^{\max}$ かつ $M>c_1$ なる全ての $M$ で*
> $$\Bigl|\,\Theta_M-b\,M\,\varphi(\ell^M)\,\Bigr|\ \le\ C\,\ell^M,\qquad
> C:=b\bigl(3+r\,\ell^{c_1}\bigr)+\theta_G^{\max}\frac{\ell+1}{\ell}+r\,\ell^{c_1}\log_\ell C_0 \tag{6.1}$$
> *（$r$ は $\bar{\tilde E}$ の相異なる原始二項式因子の本数、$c_1$ は補題 Q5 $(5.2)$。
> **$C$ は $M$ に依らない。**）したがって*
> $$\mathrm{ord}_\ell(\kappa_n)=\mu\bigl(\ell^{2n}-1\bigr)+b\,n\,\ell^{n}+O\bigl(\ell^{n}\bigr),
> \qquad b=\sum_{i=1}^rm_i=\sum_{P\in S_\infty}j^*(P). \tag{6.2}$$
> ***仮定 (F)・(N)・(B\*) はいずれも使っていない。***

**証明.** 点を $\mathcal{B}_M$ とその外に分ける。定理 Q4 より

$$\Theta_M=\sum_{P\notin\mathcal{B}_M}\bigl(\beta_P+\theta_G(P)\bigr)+\sum_{P\in\mathcal{B}_M}\hat\theta_M(P).$$

補題 Q3 を各 $i$ に使って
$\sum_{P}\beta_P=\sum_im_i\bigl((M-1)\varphi(\ell^M)+2\ell^M\bigr)=b(M-1)\varphi(\ell^M)+2b\ell^M$。
$\mathcal{B}_M$ の分を引くと、$0\le\sum_{\mathcal{B}_M}\beta_P\le|\mathcal{B}_M|\,b\,\ell^M$ より

$$\Bigl|\sum_{P\notin\mathcal{B}_M}\beta_P-b\,M\,\varphi(\ell^M)\Bigr|
\le b\,\varphi(\ell^M)+2b\ell^M+|\mathcal{B}_M|b\ell^M\le\bigl(3b+|\mathcal{B}_M|b\bigr)\ell^M.$$

残り 2 つは
$0\le\sum_{P\notin\mathcal{B}_M}\theta_G(P)\le\theta_G^{\max}(\ell+1)\ell^{M-1}$、
補題 Q0 より $0\le\sum_{\mathcal{B}_M}\hat\theta_M(P)\le|\mathcal{B}_M|\varphi(\ell^M)\log_\ell C_0
\le|\mathcal{B}_M|\ell^M\log_\ell C_0$。
ここで補題 Q0 は $\tilde E(\omega_P)\neq0$ を仮定しているので、それを確認しておく:
**$\mathcal{B}_M$ の点でも仮定 (H) より $\tilde E(\omega_P)\neq0$ である**（(H) は各段の
$X_{\ell^n,\ell^n}$ が連結、すなわち $\kappa_n\neq0$ を意味し、cycle 14 $(6.1)$ の $\Sigma_n$ が有限
＝すべての $P$ で $\hat\theta_M(P)<\infty$ と同値である）。
最後に $|\mathcal{B}_M|\le r\ell^{c_1}$（補題 Q5）を代入し、三角不等式で $(6.1)$。

> **訂正・補足（cycle 23 step 1、2026-08-01）— 2 点。**
> **(i)** 初稿の $(6.1)$ は $C:=b(3+|\mathcal{B}_M|)+\theta_G^{\max}\frac{\ell+1}{\ell}+|\mathcal{B}_M|\log_\ell C_0$
> と書き、§0 の結論表は「**明示定数 $C$ つき**」と銘打っていた。しかし $|\mathcal{B}_M|$ は
> **レベル $M$ ごとの実際の悪い点の個数**であって $M$ に依存する量であり、これでは明示定数ではない。
> 補題 Q5 の上界 $r\ell^{c_1}$ を代入した形に直した（上の $(6.1)$）。
> **(ii)** 初稿は補題 Q0 の仮定 $\tilde E(\omega_P)\neq0$ が $\mathcal{B}_M$ 上で成り立つことを
> 確認していなかった（(H) から従うので誤りではないが、依存が読めなかった）。上に明示した。
> **どちらも cycle 22 step 4（`cycle22_ops_lean_cycle21_theorems.md` §2・§4、
> Lean の `theorem_Q1_error` / `theorem_Q1_error_explicit`）が指摘した。**
> **定理 Q1 の結論（$(6.2)$）と §8 の照合結果は変わらない**（$C$ を $M$ 非依存な上界へ緩めただけで、
> $(6.1)$ は初稿の $C$ でも新しい $C$ でも成り立つ）。

$(6.2)$: 補題 J1（無仮定）より $\Sigma_n=\sum_{M\le n}\Theta_M$。$(6.1)$ を $M_1\le M\le n$ で足し、
$M<M_1$ は有限個なので定数に吸収する。
$\sum_{M=1}^nM\varphi(\ell^M)=\sum_{M=1}^nM(\ell^M-\ell^{M-1})$ の $n\ell^n$ 係数は
$\frac{\ell}{\ell-1}\cdot\frac{\ell-1}{\ell}=1$、$\sum_{M\le n}\ell^M=O(\ell^n)$。
よって $\Sigma_n=b\,n\ell^n+O(\ell^n)$。$(1.1)$ に代入し、$-2n+v_\ell(\kappa(X))=O(\ell^n)$ を
誤差へ入れて $(6.2)$。$\blacksquare$

> **系 Q6.** *定理 J7・系 W6 の結論（$n\ell^n$ の係数が $b=\sum_{P\in S_\infty}j^*(P)$）は
> **仮定なしに**成り立つ。とくに cycle 20 §7.2 (a) が「予想であって定理ではない」と明記していた
> 「(B\*) が破れても $b$ は当たる」は**定理である**。*

**証明.** 定理 Q1 と $(1.3)$（cycle 20 定理 W1・W4）。$\blacksquare$

> **系 Q7.** *$\ell=2$ を除外しない。とくに $\ell=2$ トーラスの $b=2$ は定理 Q1 の帰結である。*

**証明.** 定理 Q1 の証明のどこにも $\ell$ が奇であることは使っていない。
$\ell=2$ トーラスでは $\bar{\tilde E}=w(z-1)^2+z(w-1)^2$ で、$\mathbb{F}_2$ 上
$\bar{\tilde E}=(z+w)(zw+1)=w\bigl(\chi^{(1,-1)}-1\bigr)\cdot\bigl(\chi^{(1,1)}-1\bigr)$
（$\mathbb{F}_2$ では $-1=1$）なので $r=2$、$m_1=m_2=1$、$b=2$。$\blacksquare$

**step 1(19) §5.4 は「$\ell=2$ トーラスについては $(5.2)$ が当たることは照合であって証明ではない」
と書いていた。それは解消された。** cycle 16 定理 D2（別の議論で $b=2$ を出していた）の
独立な別証明にもなっている。

---

## 7. (B\*) は何を保証していたのか（どの結論がどこまで生き残るか）

本 step の結論は「(B\*) は $b$ には不要」である。では (B\*) は何のための仮定だったのか。
**実測で切り分けた。**

### 7.1 (B\*) の破れは「悪い点」でしか起きない（実測。内訳つき）

検証 Step F/I（`q2_pointwise.out`）は、同じ掃引の中で
(i) 定理 Q4 の $(4.3)$ が等号で成り立つか、
(ii) (B\*)（定理 B′ の最小点の一意性、および実測が最小値に一致するか）が破れているか、
を**点ごとに**数えた。

| 量 | 実測 |
|---|---|
| 「良い点」（$(4.2)$ を満たす点）の総数 | **17781** |
| そのうち $(4.3)$ が破れた点 | **0** |
| 「悪い点」（$\mathcal{B}_M$）の総数 | **765** |
| (B\*) が実際に破れた点の総数 | **143** |
| **そのうち「良い点」で破れたもの** | **0** |

**すなわち (B\*) の破れは、$\mathcal{B}_M$（$S_\infty$ の点の最内側の $O(1)$ 個）でしか起きていない。**
これは構造的に予想される: (B\*) の破れ＝$\Phi_{(a,b)}$ の 2 付値 Newton 多角形での同点であり、
分解の言葉では **$B$ 側（付値 $\beta_P$）と $\ell H$ 側（付値 $\ge\varphi(\ell^M)$）の拮抗**である。
拮抗するのは $\beta_P\approx\varphi(\ell^M)$ のとき、すなわち $\mathcal{B}_M$ の中だけである。

### 7.2 生き残る結論と、生き残らない結論

| 結論 | (B\*) 無しで | 理由 |
|---|---|---|
| $n\ell^n$ の係数 $b=\sum m_i$ | **成り立つ**（定理 Q1） | $\mathcal{B}_M$ は $O(1)$ 点なので $O(\ell^M)$ しか動かせない |
| 点ごとの $\hat\theta_M(P)$（$P\notin\mathcal{B}_M$） | **成り立つ**（定理 Q4） | 分解の 2 項が拮抗しない |
| 点ごとの $\hat\theta_M(P)$（$P\in\mathcal{B}_M$） | **成り立たない** | 実測で $\Lambda$ より深くなる（cycle 20 §8.1 の 164 件はすべて「実測 $>\Lambda$」） |
| $\ell^n$・$n$・定数の係数 $c,d,e$ | **出ない** | $\mathcal{B}_M$ の寄与が $\ell^M$ のオーダーで効くので、誤差項の中身を開けないと決まらない |

**したがって (B\*) が本質的に保証していたのは「最内側の $O(1)$ 個の点での付値の正確さ」であり、
それは $\ell^n$ 以下の係数にだけ効く。$n\ell^n$ には効かない。**
これが本 step の切り分けである。cycle 20 §8.2 が「$G_0$ は $b$ には効かないが $c,d,e$ には効く」と
書いたのと同じ切れ目に、(B\*) も乗っている。

### 7.3 可算と非可算の分別（$\mathbb{R}$ 脱出の明示）

- **$b$ の決定**: $\bar{\tilde E}\in\mathbb{F}_\ell[z^{\pm},w^{\pm}]$ の原始二項式因子の重複度の総和。
  有限体上の有限計算だけで決まる（cycle 20 定理 W3 の手続き）。**可算・決定可能。**
- **$\hat\theta_M$ の計算**: 整数終結式の $\ell$ 進付値（定理 L4）。**整数の計算だけ。**
- **$\theta_G^{\max}$**: $\mathbb{F}_\ell$ 上の有限計算 + コンパクト性。有効上界は系 L3′ を $G$ に適用すれば得られる
  （系 L3′ の証明は $\tilde E$ に固有の性質を使っていない）。**可算。**
- **$\mathbb{P}^1(\mathbb{Z}_\ell)$ は非可算**だが、本 report の主張はすべて有限レベル
  $\mathbb{P}^1(\mathbb{Z}/\ell^M)$（有限集合）への還元を経由する。非可算集合の元を個別に扱ってはいない。
- **$\mathbb{R}$（アルキメデス素点）へ脱出するのは補題 Q0 ただ 1 箇所**である。
  役割は「$\mathcal{B}_M$ の $O(1)$ 個の点の寄与を $O(\ell^M)$ で押さえる」ことだけで、
  $b$ の値にも $b$ の決定手続きにも入ってこない。
  **非アルキメデス的な議論だけでこの上界を得る道は本 step では見つからなかった**（§9.3）。

---

## 8. 検証（何をどう測ったか）

検証コードは `sagemath/check/cycle21_T3_b_star/`。対象ラベルの宣言は同ディレクトリの `overview.md`。

**設計要件（cycle 19・20 で 3 回再発した事故への対策）**: 1 本のスクリプトの壁時計上限を
20 分以内に設計し、超えるなら分割する。**3 本に分割し、実測は 1.6 秒 / 16.6 秒 / 2.3 秒**で、
いずれも前景で完走した。**打ち切り 0 件。**

中心となる実測量は cycle 20 と同じ

$$\hat\theta_M(a,b)=v_\ell\Bigl(\mathrm{Res}_y\bigl(\Psi_{\ell^M}(y),\,R_{(a,b)}(y)\bigr)\Bigr),
\qquad R_{(a,b)}(y)=\sum_{(p,q)}c_{pq}\,y^{(pa+qb)\bmod\ell^M}$$

（定理 L4）であり、**本 report の理論から独立**である（定理 B′ の一意性のような仮定を置かない）。

### 8.1 `q1_decomposition.sage`（1.6 秒、FAIL 0）

| Step | 走査した範囲 | 結果 |
|---|---|---|
| A | 母集団 124 塔 × $\ell\in\{2,3,5,7,11\}$ のうち (H) を満たす **461 組** | 分解 $\tilde E=BG+\ell H$ の恒等式の破れ **0 件** |
| B | 同 461 組 | $\bar G$ に二項式因子が残った件 **0 件**、$\theta_G=\infty$ の件 **0 件**、レベル $\le3$ で $\theta_G^{\max}$ が安定しなかった件 **0 件** |
| C | 同 461 組 | $b=\sum m_i$（本 report）と $b=\sum j^*$（cycle 20 定理 W4）の不一致 **0 件**、$|S_\infty|=r$ の不一致 **0 件** |
| D | $(\ell,M,v)$ の **108 組** | 補題 Q3 の破れ **0 件**（最初の式は誤り。§10.1） |
| E | **1518 点** | 補題 Q0 の破れ **0 件**。最悪比 $4.0000$ / 上界 $4.3219$ |

$b$ の分布は cycle 20 §7.2 (c) の表と**完全に一致**した（独立実装での再現）:

| $\ell$ | $b=0$ | $b=1$ | $b=2$ | $b=3$ | $b=4$ |
|---|---|---|---|---|---|
| 2 | 8 | 3 | 67 | 9 | 0 |
| 3 | 34 | 7 | 44 | 0 | 1 |
| 5 | 87 | 1 | 8 | 0 | 0 |
| 7 | 93 | 0 | 3 | 0 | 0 |
| 11 | 95 | 0 | 1 | 0 | 0 |

$\theta_G^{\max}$ の分布（**内訳を出す**）: $0{:}133,\ 2{:}181,\ 3{:}1,\ 4{:}104,\ 5{:}7,\ 6{:}32,\ 7{:}3$。
$\theta_G^{\max}\le7$ に収まっており、$\varphi(\ell^M)>\theta_G^{\max}$ は $\ell=2$ なら $M\ge4$、
$\ell\ge3$ なら $M\ge2$ で満たされる。

### 8.2 `q2_pointwise.sage`（16.6 秒、FAIL 0）

18 塔（cycle 20 §8.1 の (B\*) 反例 2 件を必ず含む）× $\ell\in\{2,3,5,7\}$ × レベル
（$\ell=2$: $M\le7$、$\ell=3$: $M\le5$、$\ell=5$: $M\le3$、$\ell=7$: $M\le2$）。結果は §7.1 の表。

**悪い点の個数の $M$ 依存（補題 Q5 の実測。$M$ について有界であるべき）** — 抜粋:

| 塔 | $\ell$ | $M=1,2,3,4,5,6,7$ の $|\mathcal{B}_M|$ |
|---|---|---|
| トーラス $(1,0),(0,1)$ | 2 | 3, 6, 4, 4, 4, 4, 4 |
| bouquet $(1,0),(0,1),(1,1),(1,-1)$ | 2 | 3, 6, 12, 0, 0, 0, 0 |
| bouquet $(1,0),(0,1),(1,1),(1,-1)$ | 3 | 4, 6, 6, 6, 6 |
| bouquet $(1,0),(1,-1),(1,2)$ | 3 | 4, 12, 1, 1, 1 |

浅いレベルでは $\varphi(\ell^M)$ が小さいので多くの点が「悪い点」になるが、
$M$ が上がると一定値に落ち着く。補題 Q5 の主張（$M$ に依らない上界）と整合する。

### 8.3 `q3_aggregate.sage`（2.3 秒、FAIL 0）

| Step | 走査した範囲 | 結果 |
|---|---|---|
| J/L/M | 9 塔（ADV 6 ＋ 母集団外 3）× $\ell\in\{2,3,5\}$ × レベル、**128 組** | $(6.1)$ の**明示定数**の破れ **0 件** |
| K | 9 塔 × $\ell\in\{2,3\}$、**42 段** | $\sum_M\Theta_M$ から作った $\mathrm{ord}_\ell(\kappa_n)$ と Matrix–Tree の塔の値の食い違い **0 件**、取れなかった塔 **0** |

**(B\*) が破れる 2 塔での誤差の実測**（これが本 step の眼目。cycle 20 は当てはめでしか言えなかった）:

| 塔 | $\ell$ | $b$ | $\Theta_M$（$M=1,\dots$） | $\bigl|\Theta_M-bM\varphi(\ell^M)\bigr|/\ell^M$ | $(6.1)$ の $C$ |
|---|---|---|---|---|---|
| トーラス $(1,0),(0,1)$ | 2 | 2 | 7, 16, 44, 108, 252, 572, 1276 | 2.50, 2.00, 2.50, 2.75, 2.88, 2.94, 2.97 | 26.00 |
| bouquet $(1,0),(0,1),(1,1),(1,-1)$ | 3 | 4 | 16, 88, 352, 1288, 4528 | 2.67, 4.44, 5.04, 5.24, 5.30 | 51.14 |

誤差比は増加しつつ有界に留まり（それぞれ $3$、$16/3$ へ収束しているように見える）、
$(6.1)$ の明示定数の内側に十分収まっている。$\Theta_3=44$（$\ell=2$ トーラス）は
step 1(19) §5.4 が「真値 $\Theta_3=44$」と記録した値と一致する。

---

## 9. 証明したことと、数値支持どまりのことの区別

### 9.1 証明したもの（有限個の例に依らない証明が本文にある）

補題 Q0、補題 Q1′、補題 Q2、補題 Q3、定理 Q4、補題 Q5、**定理 Q1**、系 Q6、系 Q7。
**これらはいずれも (F)・(N)・(B\*) を持たない。** 残る前提は仮定 (H) と
「$E$ がレベル $\le n$ の 1 の冪根の組で消えない」（$(1.1)$ 自体が要求するもの）だけである。

### 9.2 数値支持どまりのもの（検出力を明記する）

**(a) 「$|\mathcal{B}_M|$ が実際に小さい」**

補題 Q5 は $|\mathcal{B}_M|\le r\ell^{c_1}$ を**証明**しているが、
実測値（多くの塔で $\le12$）がこの上界よりずっと小さいことは**測定**である。
標本は 18 塔 × 4 素数 × レベルで、母集団の外について本 report は何も主張しない。
なお定理 Q1 の成立自体は $|\mathcal{B}_M|$ の実測値に依存しない（証明された上界で足りる）。

**(b) 「誤差比が収束する」**

§8.3 の表で $|\Theta_M-bM\varphi(\ell^M)|/\ell^M$ が一定値へ収束するように見えることは
**観察であって証明ではない**。証明したのは有界性 $(6.1)$ だけである。
収束するなら $\ell^n$ の係数 $c$ が決まるはずだが、それは §9.3 の未解決である。
標本は 2 塔 × 7 レベル・5 レベルで、**「収束する」という主張の検出力は無いに等しい**
（レベル数が一桁で、$M\to\infty$ の主張の反例はもっと深いレベルにありうる）。

**(c) 母集団の分類（§8.1 の $b$ の分布）**

これは**宣言した有限母集団の全走査**であり標本抽出ではない。
母集団の境界（bouquet は 2–3 ループ、2 頂点は 3 重辺、voltage は指定した 6 種／4 種、$\ell\le11$）を
明示する。母集団の外について本 report は何も主張しない。
ただし定理 Q1 は母集団に依存しない証明を持つので、母集団は**証明の検算**であって根拠ではない。

### 9.3 検出力についての注意

$(4.3)$ の 17781 点は「全走査」であって抽出標本ではない（掃引した塔・素数・レベルの全点）。
したがって「破れ率 $p$ を $95\%$ で除外できるのは…」という議論は当てはまらない。
代わりに走査範囲を明示した（§8.2）。**走査範囲の外に反例が無いことは主張しない**が、
$(4.3)$ には有限個の例に依らない証明がある（定理 Q4）ので、
数値は証明の検算であって根拠ではない。

---

## 10. 自分が途中で犯した誤り（隠さず記録する）

### 10.1 数え上げの式を間違えた（補題 Q3）

最初に書いた式は $\sum_P\ell^{\rho_v(P)}=M\varphi(\ell^M)+\ell^M$ だった。
$\mathbb{P}^1(\mathbb{Z}/\ell^M)$ の点数を $\ell^M$ と思い込み、$\rho_v=0$ の層の個数を
$\varphi(\ell^M)$ と数えたためである。正しくは点数は $(\ell+1)\ell^{M-1}$ で、
$\rho_v=0$ の層は $\ell^M$ 個ある。**正しい式は $(M-1)\varphi(\ell^M)+2\ell^M$。**

**なぜ気付いたか**: 検証 Step D が 108 件全部 FAIL を出したから。
$\ell=5,M=1$ で「実測 10 / 予言 9」という**内訳**が出ていたので、
1 だけずれていることがすぐ見え、$\mathbb{P}^1$ の点数の数え違いだと特定できた。
**PASS/FAIL だけを出す検証だったら「証明が間違っている」と誤読していた。**
cycle 20 の申し送り（内訳を吐かせる）がそのまま効いた。

**影響**: 主要項 $M\varphi(\ell^M)$ は変わらないので定理 Q1 の結論は変わらない。
変わるのは $(6.1)$ の定数（$b(1+|\mathcal{B}_M|)$ → $b(3+|\mathcal{B}_M|)$）だけである。

### 10.2 明示定数を証明より甘く実装していた

検証スクリプト `q3_aggregate.sage` の最初の版は $C=b(1+|\mathcal{B}_M|)+\cdots$ を使っていた。
これは §6 の証明が実際に与える $C=b(3+|\mathcal{B}_M|)+\cdots$ より**厳しい**（小さい）値である。
偶然そちらでも 128 組すべて通ったが、**検証が証明と別のものを測っている**状態だったので、
証明どおりの定数に直して再実行した（結果は同じく FAIL 0）。

### 10.3 課題設定の筋を誤解しかけた

指示は「定理 L4（終結式）が同点でも値を出すので、終結式の側から $\Theta_M$ を評価せよ」だった。
最初はこれを「$\Theta_M$ 全体を 1 個の終結式（$\prod_P\tilde E(\omega_P)$ のノルム）として評価する」
と読み、その積が塔の値そのものになって**循環する**ところまで進んでから引き返した。
効いたのは終結式ではなく**整数への持ち上げ**である（§2 の枠内に記録した）。

### 10.4 「(B\*) を潰す」と「(B\*) を迂回する」を区別していなかった

本 step の結論は「(B\*) が破れる点で正しい値を出せるようになった」**ではない**。
$\mathcal{B}_M$ の点では依然として $\hat\theta_M$ の閉じた式を持っていない（§7.2 の表）。
**「$b$ には効かないことを証明した」だけである。** 最初の草稿でここを曖昧に書きかけたので、
§7 を独立の節に立てて切り分けた。

---

## 11. 既知性・新規性 — 定理 Q1 は Cuoco–Monsky Theorem 1.7 である

**新規性は主張しない。それどころか、定理 Q1 は 1981 年の既知定理そのものである。**
これは本 step のもう 1 つの成果なので、根拠を明示して書く。

cycle 16（`cycle16_T1_monsky_primary_sources.md` §3.2）は
A. A. Cuoco, P. Monsky, *Class Numbers in $Z_p^d$-Extensions*, Math. Ann. **255** (1981), 235–258
の pp.237–238 を GDZ の IIIF から取得し、**原文を書き写している**。該当箇所:

> **Definition 1.1.** *$m_0(F)$ is the power to which $p$ divides $F$.*
>
> **Definition 1.2.** *Write $F=p^{m_0}\cdot F_0$ with $\bar F_0\neq0$. Then $l_0(F)=\sum\mathrm{ord}_P(\bar F_0)$,
> the sum extending over all $P$ of the form $(\bar\sigma-1)$, $\sigma\in E-E^p$. [In other words, $l_0(F)$ is the
> number of irreducible factors of $\bar F_0$ of the form $\bar\sigma-1$, $\sigma\in E-E^p$, counted with multiplicity.]*
>
> **Definition 1.3.** *$\Sigma_n(F)=\sum\mathrm{ord}\,F(\zeta-1)$, the sum extending over all $\zeta\in W^d$ with $\zeta^{p^n}=1$.*
>
> **Theorem 1.7.** *Suppose $F\neq0$. $\Sigma_n(F)=(m_0p^n+l_0n+O(1))p^{(d-1)n}$ where $m_0=m_0(F)$, $l_0=l_0(F)$.*

**対応表**（$d=2$、$p=\ell$、$F=\tilde E(1+T_1,1+T_2)\in\Lambda_2=\mathbb{Z}_\ell[[T_1,T_2]]$）:

| Cuoco–Monsky | 本プロジェクト | 一致の根拠 |
|---|---|---|
| $\Sigma_n(F)=\sum_{\zeta^{p^n}=1}\mathrm{ord}\,F(\zeta-1)$（Def 1.3） | $(1.1)$ の $\Sigma_n=\sum_{\zeta^{\ell^n}=\xi^{\ell^n}=1}v_\ell(E(\zeta,\xi))$ | 同じ和。$(\zeta,\xi)=(1,1)$ の項は $E(1,1)=0$ で、CM の規約 $\mathrm{ord}\,0=0$（p.237）により寄与 0。単項式因子 $z^rw^s$ は 1 の冪根＝単元で付値に影響しない |
| $m_0(F)$＝$F$ を割る $p$ の冪（Def 1.1） | $\mu=v_\ell(\mathrm{content}\,D)$ | 定義が同じ |
| $l_0(F)$＝$\bar F_0$ の $\bar\sigma-1$（$\sigma\in E-E^p$、すなわち $\sigma$ が $p$ 冪でない＝原始）型既約因子の**重複込みの個数**（Def 1.2） | $b=\sum_i m_i$＝$\bar{\tilde E}$ の原始二項式因子 $\chi^{v_i}-1$ の重複度の総和（$(1.2)$、cycle 20 系 W6） | $E=\Gamma\cong\mathbb{Z}_\ell^2$、$\bar\sigma-1\leftrightarrow\chi^{v}-1$、$\sigma\in E-E^p\leftrightarrow v$ 原始。**同じ定義である** |
| Theorem 1.7: $\Sigma_n=(m_0p^n+l_0n+O(1))p^{(d-1)n}$ | 定理 Q1 $(6.2)$: $\Sigma_n=\mu\ell^{2n}+b\,n\ell^n+O(\ell^n)$ | $d=2$ を代入すると同一の式 |

**したがって定理 Q1（$b$ の部分）は Cuoco–Monsky Theorem 1.7 ＋ Definition 1.2 そのものであり、
1981 年から知られている。** 本 step が新たに与えたのは
**グラフ側の設定に閉じた、$\Lambda_2$ の一般論を使わない初等的な証明**（§3–§6）だけである。

**この同定は本プロジェクトにとって重要な情報である**（既出性チェック）:

- cycle 19 定理 J7・cycle 20 系 W6 は、**仮定 (B\*) 付きの、既知定理より弱い主張**だった。
  (B\*) を落とした形（定理 Q1）は既知定理と一致する。**論文本文で $b$ の式に新規性を主張してはならない。**
- ただし cycle 20 定理 W3（$S_\infty$ の判定手続き）・定理 W4（$j^*$＝重複度）は、
  CM の $l_0$ の**定義**を「グラフの $D$ の係数からの有限手続き」へ落とす部分にあたり、
  CM の Definition 1.2 がそのまま与えているとは限らない（CM は $\Lambda$ の素元の話をしている）。
  ここは**別途の照合が要る**（本 step では確認していない。§12 の未確認事項）。
- 誤差項の比較: CM の $O(1)\cdot p^{(d-1)n}$ は本 report の $O(\ell^n)$ と同じ強さである。
  したがって **$c,d,e$（$\ell^n$ 以下の係数）は CM でも決まっていない**
  （Monsky 1989 が $d=2$ で $\alpha^*$ が有理数であることまでしか言えていないのと整合する。
  `cycle18_T1_monsky1989_acquisition.md`）。§9.2 の未解決は既知の未解決と同じ場所にある。

**確認できていないこと**: Cuoco–Monsky の §1 は原文を読んでいる（cycle 16 が取得済み）が、
**Theorem 1.7 の証明（Lemma 1.4/1.5/1.6 とその依拠する Monsky *On p-adic power series* の
Theorem 2.1–2.9）は読んでいない。** したがって「本 report の §3–§6 の証明が CM の証明と
同じものか、別の証明か」は判定していない。**別証明だと主張しない。**

---

## 12. 敵対的レビュー（自分の結論を反証しにいった記録）

| 疑い | 検査 | 結果 |
|---|---|---|
| 定理 Q4 が「良い点」の定義を都合よく取っているだけで、実は良い点が $M$ とともに減るのでは | 良い点・悪い点の個数を $M$ ごとに出した（§8.2） | 良い点は $M$ とともに増え（$\ell=2$ トーラスで $8,20,44,92,188$）、悪い点は一定に落ち着く。逆である |
| (B\*) が破れる点が実は良い点にも紛れていて、$(4.3)$ の一致は偶然では | 同じ掃引で (B\*) の破れを点ごとに判定し、良い点／悪い点で分けた（§7.1） | (B\*) の破れ 143 点は**すべて悪い点**。良い点での破れ 0 件 |
| $b$ の定義が cycle 20 と食い違っていないか（自分の実装で $b$ を作り直している） | 母集団 461 組で $\sum m_i$ と $\sum j^*$ を独立に計算して照合、さらに $b$ の分布を cycle 20 §7.2 (c) の表と突き合わせ | 不一致 0 件、分布は完全一致 |
| $\Theta_M$ の実装が cycle 19・20 と食い違っていないか | $\ell=2$ トーラス $M=3$ の $\Theta_3$ を先行 report の記録と照合 | $44$ で一致（step 1(19) §5.4 の「真値 $\Theta_3=44$」） |
| $(6.1)$ の $O(\ell^M)$ が実は $M$ に依存する定数を隠していないか | $(6.1)$ の $C$ を各レベルで実際に計算し、実測誤差と比較（§8.3） | $C$ は $M\ge$ 小さいレベルで一定になる（$|\mathcal{B}_M|$ が一定になるため）。誤差は $C$ の内側 |
| $b\ge3$ の塔で崩れないか | $\ell=3$・$b=4$ の塔（(B\*) 反例 2）と、母集団外の塔 3 個を追加して掃引 | FAIL 0 件 |
| 塔の値（Matrix–Tree）と食い違っていないか | $\sum_M\Theta_M$ から $(1.1)$ で作った $\mathrm{ord}_\ell(\kappa_n)$ を 42 段で照合 | 食い違い 0 件 |
| 既知定理と主張がずれていないか（自分が強く言いすぎていないか） | CM Theorem 1.7 の原文（cycle 16 が書き写したもの）と対応表を作った（§11） | **むしろ本 report の方が弱い**（既知定理そのもの）。新規性は主張しない |

---

## 13. 次に何が残ったか（障害の具体化）

**「まだ出来ていない」で終わらせないために、何が妨げているかを書く。**

1. **$\ell^n$ の係数 $c$（および $n$・定数の $d,e$）**。定理 Q1 の誤差項 $O(\ell^M)$ の中身は
   $\sum_{P\notin\mathcal{B}_M}\theta_G(P)$（$G$ 側の浅い付値の総和）と
   $\sum_{P\in\mathcal{B}_M}\hat\theta_M(P)$（最内側の $O(1)$ 点）の 2 つである。
   **前者は定理 Q4 の等式から原理的に計算できる**（$\theta_G$ は $\mathbb{P}^1(\mathbb{Z}/\ell^{L})$ を
   経由する有界関数なので $\sum_P\theta_G(P)=\ell^{M-L}\Theta^G_L$ の形になるはず）。
   **妨げは後者である**: $\mathcal{B}_M$ の点で $\hat\theta_M$ を決めるには
   $\ell H$ 側の付値、すなわち $\bar G_0$ を割った残り $H$ の情報が要り、
   それは $\bmod\ \ell$ の因数分解の外にある。cycle 20 §8.1 の診断がここでも生きている。
   **次の一手**: $\mathcal{B}_M$ の点だけを取り出して $H$ 側に同じ分解を再帰的に適用する
   （$\bar H$ の二項式因子を括り出す）。これは cycle 20 定理 L1 の桁枝再帰と同じ形の再帰になるはずである。
2. **補題 Q0 の非アルキメデス版**。$\mathcal{B}_M$ の $O(1)$ 点の粗上界を
   $\mathbb{C}$ の絶対値を使わずに得たい。現状は「$0$ でない整数のノルムは $1$ 以上」という
   アルキメデス的な議論に依存している。**妨げ**: 非アルキメデス的評価は下界しか与えない。
   代替として「$\tilde E$ が $\Lambda_2$ で $\ell$ で割れないこと（$\mu$ の定義）から
   Weierstrass 準備定理経由で上界を出す」道が考えられるが、本 step では試していない。
3. **cycle 20 定理 W3・W4 が Cuoco–Monsky の枠組みで既出かどうか**（§11）。
   CM Definition 1.2 は $l_0$ を $\Lambda$ の素元の言葉で定義しているだけで、
   「$D$ の係数からの有限手続き」を与えているかは原文の §2 以降を読まないと判定できない。
   **未読である。** 論文本文で W3・W4 の位置づけを書くときは、ここを埋めてからにすること。

---

## 付録: 検証コードと実行

```bash
cd integrable-lattice/sagemath/check/cycle21_T3_b_star
sage q1_decomposition.sage > q1_decomposition.out 2>&1   # 1.6 秒
sage q2_pointwise.sage     > q2_pointwise.out     2>&1   # 16.6 秒
sage q3_aggregate.sage     > q3_aggregate.out     2>&1   # 2.3 秒
```

**FAIL 合計 0 件、打ち切り合計 0 件。** 詳細は各 `.out` と `overview.md`。
