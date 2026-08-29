import { defineBlocks, displayMath, math, paragraph } from "../schema.ts";

export default defineBlocks([
  {
    id: "article_scope_definition_finite_quotient_regular_cellulated_closed_hyperbolic_surface",
    kind: "definition",
    title: { text: "有限商正則セル分割付き閉双曲曲面" },
    labels: ["def_finite_quotient_regular_cellulated_closed_hyperbolic_surface"],
    habitat: "mixed",
    realEscape: "対象の成分 h が曲率 -1 の Riemann 計量であることだけが実数を用いる。その他の成分は HF(N) 内の有限データである。",
    statement: [
      paragraph([
        math(String.raw`\operatorname{HF}(\mathbb N)`),
        " を自然数から有限回の有限集合形成と順序対形成で得られる遺伝的有限集合の集合とする。本論文の対象を次の一つの集合として定める。",
      ]),
      displayMath(String.raw`\mathcal H_{\mathrm{fq}}:=\left\{
(\mathcal Q,X,p,q,h)\ \middle|\
\begin{array}{l}
p,q\in\mathbb N_{>0},\quad 1/p+1/q<1/2,\\
\mathcal Q=(\Omega,Q,r_F,r_V,r_E)\in\operatorname{HF}(\mathbb N),\\
\Omega\ne\varnothing\text{ は有限},\quad Q\leq\operatorname{Sym}(\Omega),\quad
r_F,r_V,r_E\in Q,\\
Q=\langle r_F,r_V,r_E\rangle,\quad
\operatorname{ord}(r_F)=p,\quad\operatorname{ord}(r_V)=q,\quad\operatorname{ord}(r_E)=2,\\
r_Fr_Vr_E=\operatorname{id}_{\Omega},\quad Q\curvearrowright\Omega\text{ は推移的},\\
X=(H_F,H_V,H_E,\eta_E,V,E,F,\mathcal I,\partial,(P_f,s_f)_{f\in F},(w_f)_{f\in F})\in\operatorname{HF}(\mathbb N),\\
H_F:=\langle r_F\rangle,\quad H_V:=\langle r_V\rangle,\quad H_E:=\langle r_E\rangle,\\
\eta_E:Q/H_E\to Q,\\
\forall C_E\in Q/H_E\quad\eta_E(C_E)\in C_E,\\
V=\{\mathtt{vertex}\}\times Q/H_V,\quad E=\{\mathtt{edge}\}\times Q/H_E,\quad F=\{\mathtt{face}\}\times Q/H_F,\\
\partial:E\times\{\mathsf{source},\mathsf{target}\}\to V,\\
\mathcal I=
\{((\mathtt{face},C_F),(\mathtt{vertex},C_V))\mid C_F\in Q/H_F,C_V\in Q/H_V,C_F\cap C_V\ne\varnothing\}\\
\qquad\cup\{((\mathtt{face},C_F),(\mathtt{edge},C_E))\mid C_F\in Q/H_F,C_E\in Q/H_E,C_F\cap C_E\ne\varnothing\}\\
\qquad\cup\{((\mathtt{vertex},C_V),(\mathtt{edge},C_E))\mid C_V\in Q/H_V,C_E\in Q/H_E,C_V\cap C_E\ne\varnothing\},\\
\left.\begin{aligned}
\partial((\mathtt{edge},C_E),\mathsf{source})&=(\mathtt{vertex},\eta_E(C_E)H_V),\\
\partial((\mathtt{edge},C_E),\mathsf{target})&=(\mathtt{vertex},\eta_E(C_E)r_EH_V)
\end{aligned}\right\}\quad(C_E\in Q/H_E),\\
P_{(\mathtt{face},C_F)}=\{\mathtt{position}\}\times C_F\quad(C_F\in Q/H_F),\\
s_{(\mathtt{face},C_F)}:P_{(\mathtt{face},C_F)}\to P_{(\mathtt{face},C_F)}\quad(C_F\in Q/H_F),\\
s_{(\mathtt{face},C_F)}(\mathtt{position},a)=(\mathtt{position},ar_F)
\quad(C_F\in Q/H_F,\ a\in C_F),\\
w_{(\mathtt{face},C_F)}:P_{(\mathtt{face},C_F)}\to E\times\{\mathsf{forward},\mathsf{reverse}\}
\quad(C_F\in Q/H_F),\\
w_{(\mathtt{face},C_F)}(\mathtt{position},a)=
\begin{cases}((\mathtt{edge},aH_E),\mathsf{reverse}),&\eta_E(aH_E)=a,\\
((\mathtt{edge},aH_E),\mathsf{forward}),&\eta_E(aH_E)=ar_E
\end{cases}
\quad(C_F\in Q/H_F,\ a\in C_F),\\
\text{位置 }(\mathtt{position},a)\text{ の向き付き辺は }\partial\text{ に関して }(\mathtt{vertex},ar_EH_V)
\text{ から }(\mathtt{vertex},aH_V)\text{ へ進み},\\
\text{次位置 }(\mathtt{position},ar_F)\text{ の向き付き辺は }(\mathtt{vertex},aH_V)
\text{ から進む}\quad(C_F\in Q/H_F,\ a\in C_F),\\
\text{各辺は全境界語に正向き一回・逆向き一回現れ、各頂点リンクは単巡回で、一次骨格は連結},\\
h\text{ は }|X|\text{ 上の完備 Riemann 計量},\quad K_h\equiv-1,\\
X\text{ の各面は }h\text{ に関して内角 }2\pi/q\text{ の測地的正則 }p\text{ 角形}
\end{array}\right\}.`),
      paragraph(["本論文で有限双曲曲面といった場合は、", math(String.raw`\mathcal H_{\mathrm{fq}}`), " の元を意味する。曲率負一計量の存在は、この定義とは別に証明を要する主張であり、ここでは主張しない。"]),
    ],
  },
]);
