# cycle 18 / 運用: 命題 N・T・W の本文数値を独立に再計算する

スクリプト `ntw_recheck.py`、出力 `ntw_recheck.out`（**素の Python 3。SageMath 不要**、`python3 ntw_recheck.py`）。

対応する report は `outputs/reports/cycle18_ops_lean_props_NTW.md`（cycle 18 step 3）。
**本ディレクトリは本文に書かれている数値をゼロから計算し直すものであり、計算が証明なのではない。**
証明側の形式化は `lean/IntegrableLattice/PropN.lean`・`PropT.lean`・`PropW.lean` にある。

## 対象（何を検証したか）

### 対象ラベル

- `paper_prop_T`（命題 T: 奇 $L$ で $v_2(\tau(L))=2(L-1)$、偶 $L$ では成立しない）
- `paper_prop_W`（命題 W: 適用例 $\operatorname{ord}_3(\tau(3^n))=4\cdot3^n-2n-4$）
- `paper_prop_N`（命題 N: Skolem–Mahler–Lech 型の例外集合）

### 1. 命題 T の数値（$L=2,\dots,15$）

$\tau(L)$（$C_L\times C_L$ の全域木数）を、$L^2-1$ 次の縮約ラプラシアンの**整数行列式**として計算する
（Bareiss 型の分数なし消去。浮動小数点は使わない）。既存の `cycle13_T1_tau_v2/` は SageMath の
matrix-tree 経路なので、**実装も処理系も独立**な再計算になっている。

結果（`ntw_recheck.out`）:

- 奇 $L=3,5,7,9,11,13,15$: $v_2(\tau(L))=2(L-1)$ が**全一致**。
- 偶 $L=2,4,6,8,10,12,14$: $v_2=5,19,29,61,53,83,77$ で、**本文の記載と完全一致**。

### 2. 命題 W の適用例（$\ell=3$ のトーラス塔）

$\operatorname{ord}_3(\tau(3^n))$ を $n=0,1,2$ で計算し、$0,6,28$ を得た。
本文の閉形式 $4\cdot3^n-2n-4$ と一致する。

### 3. 命題 N の例外集合

$T=\begin{pmatrix}0&1\\2&0\end{pmatrix}$（$\chi_T=x^2-2$、$\mu_{\min}(2)=1/2$）について
$\operatorname{Tr}(T^N)$ を $N=1,\dots,10$ で計算し、$0,4,0,8,0,16,0,32,0,64$ を得た。
**奇数 $N$ ではすべて $0$** であり、例外集合が有限でないことの数値側の確認である
（Lean 側の証明は `trace_cexN_pow_odd` / `cexN_exceptional_unbounded`）。
対照として $T=\begin{pmatrix}0&1\\1&0\end{pmatrix}$ も計算している。

## 結論

**本文の数値には食い違いが無かった。** 本 step で見つかった食い違いは数値ではなく
ステートメントの側（命題 N の例外集合の記述、命題 W の $\nu$ の帰属）である。詳細は report を見よ。
