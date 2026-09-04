# 単純閉路に適合する反転対の存在条件

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

一辺 $L\ge2$ のトーラスで、互いに素な辺集合 $D,E\subseteq E_L$ を取り、
$E$ は空でない連結 $2$ 正則辺集合、すなわち単一の単純閉路とする。辺集合 $F$ の
奇次数頂点集合を

$$
\partial F:=\{v\in V_L\mid d_F(v)\equiv1\pmod2\}
$$

と書く。このとき

$$
\mathcal C_L(D,E)\ne\varnothing
\quad\Longleftrightarrow\quad
\partial D\subseteq V(E).
$$

実際、$C\in\mathcal C_L(D,E)$ なら $D\cap C=\varnothing$ と
$\partial(D\cup C)=\varnothing$ から $\partial D=\partial C\subseteq V(E)$ である。
逆に $\partial D\subseteq V(E)$ なら、握手補題により $|\partial D|$ は偶数である。
$E$ を巡回順にたどり、各頂点で「直前の辺を $C$ に入れるか」と「直後の辺を
$C$ に入れるか」の排他的論理和がその頂点の $\partial D$ への所属に一致するよう、
一つの始辺から順に所属を決める。右辺の総和が偶数なので一周後の条件も一致し、
$\partial C=\partial D$、従って $D\cup C$ は偶部分グラフになる。

さらに一つの解 $C$ があれば $E\setminus C$ も解である。二解の対称差は単純閉路
$E$ の偶部分グラフであり、連結な $2$ 正則グラフでは空集合か $E$ 全体しかない。
従って選択集合はちょうどこの二解からなる。この条件は $D$ の全体ではなく
奇次数頂点だけを読み、一般の辺長で有限集合の所属判定により決定できる。

- 実行: `sage sagemath/check/simple-cycle-selector-existence/check.sage`
- 状態: PASS（2026-09-04）
- 方法: 一辺二の全ての互いに素な $(D,E)$ と、一辺三の $|D|\le2$ の全ての互いに素な $(D,E)$ を、有限集合と整数だけで検査。浮動小数点は使わない。
