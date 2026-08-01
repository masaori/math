# cycle 22 / 運用: cycle 21 の新定理群を Lean で検算する（定理 Q1・G4）

対象: cycle 21 で得た新定理群（`docs/tasks/auto-loop-state.md` の cycle 22 step 4）。
**目的は証明の正しさではなく、主張が一意に読めるか・仮定が過不足ないかの検査**である
（cycle 17: 誤り 1 件／18: 誤り 2 件／19: 過剰仮定 2 件／20: 誤り 1 件＋暗黙の仮定 1 件＋過剰仮定 2 件／
21: 主張の欠陥 1 件＋根拠不足 1 件＋記号の多義性 1 件＋過剰仮定 2 件。**本サイクルで 7 サイクル連続**）。

併せて **cycle 21 step 3 の `lake build` を独立に再実行**した（前サイクルは他セッションの並行ビルドで
呼び出し元が完走を確認できていなかった）。

前提として読んだ一次情報:
`outputs/reports/cycle21_T3_drop_assumption_B_star.md`（補題 Q0・Q1′・Q2・Q3・Q5、定理 Q4、**定理 Q1**、§7・§9–§11）、
`cycle21_T3_general_closed_form.md`（定理 G1、**定理 G2**、定理 G3、**定理 G4**、系 G5・G6、§5.3、§6）、
`cycle21_ops_lean_cycle20_theorems.md`、`lean/README.md`、`docs/tasks/auto-loop-runbook.md`。

**本 step は本文（`structured-latex/` と `structured-latex-en/`）と検査道具を一切触っていない**
（step 1・step 2 の担当。衝突回避）。成果物は `lean/` と本 report だけである。

---

## 0. 結論（先に置く）

| 検出 | 内容 | 状態 |
|---|---|---|
| **内部の食い違い 1 件（最大の成果）** | 定理 G4 §5.3 の $M^*$ の条件 2（$M\ge r^\sharp+\max K+1$）は**1 つ強すぎる**。(b) の層の閉形式 $\sum_{s=K+1}^{M-r^\sharp}\varphi(\ell^{s})=\ell^{M-r^\sharp}-\ell^{K}$ が成り立つ条件は $M\ge r^\sharp+K$ である。そして **§6.1（定理 J8 との照合）は $r^\sharp=1$, $K=0$ の下で $M^*=1$ を使っており、自分の §5.3 の条件 2 を満たしていない** | §1。**直すべきは §5.3 の条件 2**。Lean: `sum_totient_Ico` / `layer_b_boundary` |
| **「明示定数」が明示定数でない 1 件** | 定理 Q1 $(6.1)$ は「**明示定数 $C$ つき**」と銘打つが、$C$ の定義に $\mid\mathcal{B}_M\mid$ が入っており **$M$ に依存する**。補題 Q5 の上界 $r\ell^{c_1}$ を代入した形に直すべき | §2。Lean: `theorem_Q1_error` / `theorem_Q1_error_explicit` |
| **根拠が本文に無い 2 件** | (1) 補題 Q5 に効くのは**狭義**不等式 $2b<(\ell-1)\ell^{c_1}$ であり、$c_1$ の定義の $+1$ はそこに効いている（非狭義だと反例がある）。(2) 定理 G4 注 4.2「$K$ は上界であってよい」は**正しい**が、その理由（$K\to K+1$ で $(5.3)$$(5.4)$ の変化が打ち消し合う）が書かれていない | §3。Lean: `lemma_Q5_needs_strict` / `G4_K_dependence` |
| **暗黙の仮定 1 件** | 定理 Q1 の証明は $\mathcal{B}_M$ 上で補題 Q0 を使うが、補題 Q0 は $\tilde E(\omega_P)\ne0$ を仮定している。これは (H) から従うものの、証明本文で明示されていない | §4 |
| **検証範囲の逸脱 1 件（軽微）** | §6.3（$\ell=2$ トーラス）は「$n=1$ から完全に一致する」と書くが、定理 G1 の保証は $n\ge M^*-1$ であり、この塔では $M^*\ge r^\sharp+K+1=4$。**$n=1,2,3$ での一致は定理 G4 の保証範囲の外**である（一致すること自体は事実） | §5 |
| **食い違い無し** | 定理 G1 $(2.2)$$(2.3)$ の **5 係数すべて**が恒等式として通った（`theorem_G1`）。定理 G3 の $K$ の算術（$K=0\iff j^*\le\ell-2$、$\ell=2$ で必ず $K\ge1$）、定理 G2 の 2 の最小点一意性、補題 Q2 (2)・定理 Q4 の比較、補題 Q3 の数え上げも主張どおり通った。**定理 Q1 の $b$ と定理 G4 の $b$ が別経路で同じ値になること**も型で確認した | §6 |
| **検証（独立再現）** | `lake build` **8676 jobs** / `BUILD_EXIT=0`。新規 2 モジュールを除くと **8674 jobs** で、**cycle 21 step 3 の 8674 jobs を独立に再現**した。`check-no-sorry.sh` は **231 個**（cycle 21 の 196 個 + 今回 35 個）すべて `sorryAx` 非依存 / `CHECK_EXIT=0`。**cycle 21 の 196 個も本 step で再確認済み** | §7 |
| **自分が犯した誤り** | 3 件（`abs_add` の存在を確認せず使った／`IsPrimitiveRoot.sub_one_norm_prime_ne_two` を確認せず「在る」と書いた／`IsTotallyRamified` が 0 件なのを一度「完全分岐は無い」と読みかけた） | §9 |

---

## 1. 検出した食い違い: 定理 G4 §5.3 の条件 2 と §6.1 が矛盾している

### 1.1 何が書いてあるか

§5.3（$M^*$ の明示形）は、$(2.1)$ が成り立つ十分条件として 5 つを挙げ、その 2 番目が

> 2. $M\ge r^\sharp+\max_{P_0}K(P_0)+1$（(b) の層が空でない）

である。一方 §6.1（定理 J8 との照合）は $\ell$ 奇の bouquet で $r^\sharp=1$、$K=0$ と計算したうえで

> $M^*=1$ なので $(2.3)$ の角括弧は $0$ で $e=\dots=-2$

と書いている。$r^\sharp+\max K+1=2$ なので、**$M^*=1$ は §5.3 の条件 2 を満たしていない。**

### 1.2 どちらが正しいか（Lean で分けた）

§5.2 (b) が使う等式は

$$\sum_{r=r^\sharp}^{M-K-1}\varphi(\ell^{M-r})=\sum_{s=K+1}^{M-r^\sharp}\varphi(\ell^{s})=\ell^{M-r^\sharp}-\ell^{K}$$

である。`GeneralTower.sum_totient_Ico` はこの等式を $\mathbb{Z}$ 上で証明し、**成立条件が
$K\le M-r^\sharp$、すなわち $M\ge r^\sharp+K$ である**ことを型に出している。
$M=r^\sharp+K$（＝ (b) の層が**空**）でも両辺とも $0$ で成り立つ（`layer_b_boundary`）。
$M<r^\sharp+K$ では左辺は $0$、右辺は負になって初めて破れる。

**したがって条件 2 の「$+1$」は不要である。** §6.1 の $M^*=1=r^\sharp+K$ は正しく、
直すべきは §5.3 の条件 2 の方である。

### 1.3 訂正案（本 step では本文も report も触っていない。次の担当が反映すること）

§5.3 の条件 2 を

> 2. $M\ge r^\sharp+\max_{P_0}K(P_0)$（(b) の層が空になる境界まで含めて閉形式が成り立つ）

とする。括弧内の理由も「(b) の層が空でない」ではなく「(b) の閉形式が成り立つ」に直す
（空でも閉形式は $0$ を返すので、空であること自体は障害ではない）。

**なお本文（`structured-latex/content/`）には定理 G4 はまだ入っていない**（cycle 22 step 1 が
反映を担当する）。反映の際にこの訂正を織り込むこと。

---

## 2. 「明示定数 $C$」が明示定数になっていない（定理 Q1 $(6.1)$）

$(6.1)$ は

$$\bigl|\Theta_M-b\,M\,\varphi(\ell^M)\bigr|\le C\,\ell^M,\qquad
C:=b\bigl(3+|\mathcal{B}_M|\bigr)+\theta_G^{\max}\frac{\ell+1}{\ell}+|\mathcal{B}_M|\log_\ell C_0$$

で、§0 の結論表は「**明示定数 $C$ つき**」と書いている。しかし $|\mathcal{B}_M|$ は
**レベル $M$ ごとの実際の悪い点の個数**であって、$M$ に依存する量である。
直後の括弧書き「$|\mathcal{B}_M|$ は補題 Q5 より $M$ に依らず押さえられる」が補ってはいるが、
**定数として書くなら補題 Q5 の上界 $r\ell^{c_1}$ を代入しなければならない。**

Lean では三角不等式の組み立てを `theorem_Q1_error`（$|\mathcal{B}_M|$ を変数のまま）と
`theorem_Q1_error_explicit`（上界 $r\ell^{c_1}$ を代入して **$M$ 依存を消した形**）に分けてある。
後者が本来 $(6.1)$ に書かれるべき形である。

訂正案:

$$C:=b\bigl(3+r\ell^{c_1}\bigr)+\theta_G^{\max}\frac{\ell+1}{\ell}+r\,\ell^{c_1}\log_\ell C_0 .$$

---

## 3. 根拠が本文に無い 2 件

### 3.1 補題 Q5 に効くのは狭義不等式である（$c_1$ の $+1$ の役割）

補題 Q5 は $c_1:=\max\bigl(0,\lceil1+\log_\ell\frac{2b}{\ell-1}\rceil\bigr)$ と置いて
$|\mathcal{B}_M|\le r\ell^{c_1}$ を示す。証明の核は

$$2b\,\ell^{\rho_{\max}}\ \ge\ \varphi(\ell^M)=(\ell-1)\ell^{M-1}\ \Longrightarrow\ \rho_{\max}\ge M-c_1$$

である（`lemma_Q5_rho_max`）。Lean で仮定を最小化すると、**この含意に必要なのは
$2b<(\ell-1)\ell^{c_1}$ という狭義不等式**であり、非狭義 $2b\le(\ell-1)\ell^{c_1}$ では偽になる。

反例（`lemma_Q5_needs_strict`）: $\ell=2$, $b=1$, $c_1=1$, $M=3$, $\rho=1$。
$2b\ell^{\rho}=4=(\ell-1)\ell^{M-1}$ で前提を満たすが $M-c_1=2>1=\rho$ で結論が破れる。
このとき $2b=2=(\ell-1)\ell^{c_1}$ で等号が起きている。

**report の $c_1$ の定義にある $+1$ は、まさにこの等号を避けるために入っている**
（$\lceil\log_\ell\frac{2b}{\ell-1}\rceil$ だけでは $\frac{2b}{\ell-1}$ が $\ell$ の冪ちょうどのときに
等号になる）。**ところが report の証明はその役割を書いていない。**
定義に $+1$ を入れた理由を一言添えるべきである。

### 3.2 注 4.2（$K$ は上界でよい）は正しいが、理由が書かれていない

定理 G4 の $(5.3)$$(5.4)$ は $-\frac{(\ell-1)j^*(K+r^\sharp)}{\ell}$ と $-e_{j^*}\ell^{K}$ という
**$K$ に直接依存する項**を含む。したがって注 4.2 が言うように「$K$ を大きく取り直してもよい」なら、
その大きく取った $K$ を代入しても値が変わらないことが要る。

実際に $K\to K+1$ の変化を計算すると、非飽和層では $(4.2)$ より $\theta^\sharp_{K+1}=e_{j^*}$、
$\Lambda_{K+1}=j^*/\varphi(\ell^{K+1})$ なので $\gamma$ の変化は

$$-e\,\ell^{K+1}+e\,\ell^{K}+\varphi(\ell^{K+1})\,e
=e\bigl(\ell^{K}-\ell^{K+1}+\ell^{K+1}-\ell^{K}\bigr)=0$$

で**打ち消し合う**（`G4_K_dependence`）。$\beta$ 側も同様である。
**注 4.2 は正しい。しかしこの打ち消しは report に書かれていないので、
読み手は注 4.2 が本当かどうかを本文からは検証できない。** 一言添えるべきである。

---

## 4. 暗黙の仮定: 補題 Q0 の適用に要る $\tilde E(\omega_P)\ne0$

補題 Q0（アルキメデス粗上界）は「$\tilde E(\omega_P)\neq0$ ならば」という仮定つきで述べられている。
定理 Q1 の証明は $(6.1)$ の第 3 項

$$0\le\sum_{P\in\mathcal{B}_M}\hat\theta_M(P)\le|\mathcal{B}_M|\,\varphi(\ell^M)\log_\ell C_0$$

でこれを使うが、**$\mathcal{B}_M$ の各点で $\tilde E(\omega_P)\ne0$ であること（＝ $\hat\theta_M(P)<\infty$）は
証明本文で確認されていない。**

これ自体は仮定 (H) から従う（cycle 14 $(6.1)$ の $\Sigma_n$ が有限であることと同値であり、
(H) は $X_{\ell^n,\ell^n}$ の連結性＝ $\kappa_n\ne0$ を意味する）。
したがって**誤りではないが、依存が読めない**。定理 Q1 の証明に

> （$\mathcal{B}_M$ の点でも (H) より $\tilde E(\omega_P)\ne0$ なので補題 Q0 が使える）

の一言が要る。Lean では `theorem_Q1_error` の仮定 `hhat`（$\mathcal{B}_M$ 上の和が有限の上界を持つ）が
これを要求していることから読める。

---

## 5. 検証範囲の逸脱（軽微）: §6.3 の「$n=1$ から完全に一致する」

§6.3 は $\ell=2$ トーラスで $\mathrm{ord}_2(\kappa_n)=2n2^{n}+4\cdot2^{n}-6n-1$ を導き、
「$n=1,\dots,6$ で $5,19,61,167,417,987$ となり、DuBose–Vallières の数列と **$n=1$ から完全に一致する**」
と書く。数値そのものは正しい（本 step でも手で確認した）。

ただし定理 G1 の結論が保証されるのは $n\ge M^*-1$ である。この塔では $r^\sharp=2$、$K=1$ なので
§5.3 の条件 2（修正後でも $M\ge r^\sharp+K=3$）から $M^*\ge3$、したがって
**保証範囲は $n\ge2$ であり、$n=1$ での一致は定理 G4 の保証の外**である。
（さらに §5.3 の条件 4・5 を満たす $M^*$ はもっと大きくなりうる。）

これは cycle 21 step 3 が系 Y″ について検出した「$n=1,2$ の 2 点で既に食い違う」と
**同じ型の問題**（保証範囲外の小さい $n$ での一致・不一致を根拠に使っている）である。
一致は事実なので主張は壊れないが、「$n=1$ から一致する」を**定理 G4 の検証**として提示するなら、
定理の保証範囲を明記したうえで「保証範囲の外でも一致した」と書くべきである。

なお §6.1 は $M^*=1$ を根拠に $(2.3)$ の角括弧を $0$ として $e=-2$ を出しているが、
§6.3 は $e=-1$ をどう出したかを書いていない（$M^*\ge3$ なので角括弧は一般に $0$ ではない）。
最終式が DuBose–Vallières と一致する以上結果は正しいが、**導出の途中が示されていない**。

---

## 6. 食い違いが無かったところ

### 6.1 定理 G1 の 5 係数（`theorem_G1`）

$(2.1)$ を仮定として置き、cycle 14 $(6.1)$ へ代入して $\ell^{2n},n\ell^n,\ell^n,n,1$ の係数を読む段を、
$\mathbb{Q}$ 上の**恒等式**として通した。$(2.2)$ の 4 式と $(2.3)$ の $e$ が**そのまま**出る。
$\mathcal{S}_1,\mathcal{S}_0$ の閉形式（`S1_closed` / `S0_closed`）とその 3 項分解
（`S1_decomp` / `S0_decomp`）も report の書きぶりと一致した。

$M^*$ を大きく取り直しても $e$ が変わらないこと（`theorem_G1_e_indep`）も確認した。
report はこれを主張していないが、$(2.3)$ が意味を持つために必要な性質である。

注 2.2（$\Theta_M$ に $\delta M$ の項があると $n^2$ が出る）も `theorem_G1_remark_2_2` で確認した。

### 6.2 定理 G3 の算術

- $K$ の定義に使う集合が $k=0$ を含む（$j^*\ge1$, $\ell\ge2$）ので $K$ は常に定義される（`K_wellDefined`）。
- **$K=0\iff j^*\le\ell-2$**（`K_zero_iff`）。
- **$\ell=2$ では必ず $K\ge1$**（`K_ge_one_of_ell_two`）。注 4.1 の「$\ell=2$ が特別な理由」はこれで尽きる。
- $\ell$ 奇でも $j^*\ge\ell-1$ なら $K\ge1$（`K_ge_one_of_jstar_large`）。実例 $\ell=3$, $j^*=2$
  （`K_example_ell_three`: $k=1$ は飽和しうるが $k=2$ は非飽和）。
- 証明の中心の不等式 $\varphi(\ell^M)-\theta+m_1>0$（`G3_positivity`）。
- $(4.2)$ の $\Lambda_k=j^*/\varphi(\ell^k)$、$\theta^\sharp_k=e_{j^*}$ が **2 つのレベルでの一致から**
  決まること（`G3_two_levels`）。

### 6.3 最小点の一意性（補題 Q2 (2)・定理 Q4・定理 G2 の 2）

3 つとも「$\varphi(\ell^M)v_\ell(A_m)+m$ の最小点が一意」という同じ形をしている。
Lean で仮定を最小化した結果:

- 補題 Q2 (2)（`unique_min_of_val_seq`）に要るのは **$\theta_G<\varphi(\ell^M)$ だけ**。
  report の「(B\*) 型の仮定は要らない」は正確である。
- 定理 G2 の 2（`twisted_unique_min`）は、係数環を $\mathcal{O}_k$ へ広げた分を
  $q=\varphi(\ell^M)/\varphi(\ell^k)$ と整数化した付値 `w` で表すと、要るのは $(3.2)$ すなわち
  $\theta^\sharp<q+m^\sharp$ **だけ**である。$k=0$ で cycle 19 定理 S に退化する
  （`twisted_unique_min_k_zero`）ことも確認した（注 3.1 と一致）。

### 6.4 補題 Q3 の数え上げ

`lemma_Q3` で $(5.3)$ を通した。併せて**層分解が $\mathbb{P}^1(\mathbb{Z}/\ell^M)$ の分割になっている**こと
（個数の合計が $(\ell+1)\ell^{M-1}$）を `layer_card_sum` で確認した。
**report §10.1 が記録する初稿の誤り（$\rho=0$ の層を $\varphi(\ell^M)$ 個と数えた）は、
この照合をしていれば出ていた。** 初稿の式が偽であることの反例（$\ell=2$, $M=2$: 正 $10$ vs 誤 $8$）を
`lemma_Q3_old_formula_false` に、差が $\ell^M-\varphi(\ell^M)=O(\ell^M)$ で主要項に効かないことを
`lemma_Q3_diff` に置いた。**「主要項は変わらないので結論には影響しない」という report の記述は正しい。**

### 6.5 定理 Q1 と定理 G4 が同じ $b$ を出すこと

定理 Q1 は $b=\sum_i m_i$（$\bmod\ \ell$ の二項式因子の重複度の和）を、
定理 G4 は $b=\frac{\ell}{\ell-1}\alpha$、$\alpha=\frac{\ell-1}{\ell}\sum_{P_0}j^*(P_0)$ を経由して
$b=\sum j^*$ を出す。後者の代数（$\frac{\ell}{\ell-1}\cdot\frac{\ell-1}{\ell}=1$）を `theorem_G4_b` で、
$c$ の展開（$-\frac{\ell}{(\ell-1)^2}\cdot\frac{\ell-1}{\ell}J=-\frac{J}{\ell-1}$）を `theorem_G4_c` で確認した。
**2 つの report が独立の経路で同じ値に到達していることが型で読める。**

---

## 7. 検証（`lake build` と `check-no-sorry.sh` の独立再現）

### 7.1 実行前の負荷の扱い

cycle 22 step 列は「着手時にマシンの負荷平均を確認し、高ければ低くなるまで待つ」ことを求めていた。
着手時の `uptime` は **load averages: 582.69 504.34 438.75** で、cycle 21 の 432 より高かった。

しかし `top -l 1` を取ると **CPU usage: 37.9% user, 20.11% sys, 42.78% idle** であった。
すなわち **CPU は 4 割強が遊んでおり、負荷平均 582 は飽和を意味していない**。
このマシンの負荷平均は総スレッド 9377・running 277 という値に引きずられており、
**I/O 待ち・ブロック中のスレッドを大量に含むため、CPU の空き容量の指標になっていない。**

そこで負荷平均が下がるのを待つのをやめ、実際の idle を根拠にビルドを開始した。
結果として `lake exe cache get` は 66.6 秒、`lake build` は完走した（下記）。
**cycle 21 の「負荷平均 432 で完走を確認できなかった」は、負荷平均という指標の読み違いだった可能性がある。**
以後、この判断には負荷平均ではなく `top` の idle を使うべきである。

### 7.2 結果（内訳つき）

| 項目 | 結果 |
|---|---|
| `lake exe cache get` | `Completed successfully in 66601 ms!` / `CACHE_EXIT=0`（`logs/cache-get-cycle22.log`） |
| `lake build` | **`Build completed successfully (8676 jobs).`** / `BUILD_EXIT=0`（`logs/build-cycle22-Q1G4.log`） |
| `bash scripts/check-no-sorry.sh` | ソース中に `sorry` / `admit` 無し。列挙した **231 個**の定理がすべて `sorryAx` 非依存 / `CHECK_EXIT=0`（`logs/check-no-sorry-cycle22.log`） |
| 依存公理の内訳 | `[propext, Classical.choice, Quot.sound]` **175**、`[propext, Quot.sound]` **28**、`[propext]` **25**、公理なし **3**（合計 231）。`sorryAx` は **0** |

### 7.3 cycle 21 step 3 の数値は再現したか

**再現した。**

- **jobs**: 本 step は新規モジュールを **2 本**（`DropAssumptionBStar` / `GeneralTowerClosedForm`）
  追加している。$8676-2=8674$ で、**cycle 21 step 3 が報告した 8674 jobs と一致する**。
- **定理数**: 本 step は `check-no-sorry.sh` の `targets` に **35 個**追加した。
  $231-35=196$ で、**cycle 21 step 3 が報告した 196 個と一致する**。
  そして 231 個すべてが `sorryAx` 非依存で通っているので、**cycle 21 の 196 個も本 step で
  独立に再確認されている**。

したがって「8674 jobs／196 定理が sorryAx 非依存」は、本 step の実行ログを一次情報として確認済みである。

---

## 8. 形式化しなかったもの（mathlib の欠落か配線か）

一次情報は `lean/logs/mathlib-gap-survey-cycle22.log`（3 段方式 + targeted 追加）。
**「無い」と書く前に必ず (2) 語幹の内容 grep と (3) ファイル名検索の両方を 0 にすること**という
cycle 16 以来の規約に従い、0 でないものはヒットの中身を読んで判定した。

### 8.1 配線（mathlib に在るが繋いでいない）

| 未形式化の箇所 | mathlib の状況 | 判定 |
|---|---|---|
| 補題 Q4a（$v_{\mathfrak l}(B(\omega_P))=\beta_P$）・定理 G2 の 1・3 | `IsCyclotomicExtension` **15 件**、`zeta_sub_one_prime` **3 件**、`autEquivPow` **2 件**、`IsCyclotomicExtension.Rat` **8 件**、`ramificationIdx` **16 件**、`inertiaDeg` **15 件** | **配線** |
| 補題 Q1′（$\bar{\tilde E}=\bar B\bar G$ の一意性） | **1 変数** Laurent は `Mathlib/Algebra/Polynomial/Laurent.lean` に在る。**2 変数 Laurent 環の型は無い**（`Polynomial.laurent` / `MvPolynomial.Laurent` ともに 0 件）が、`MvPolynomial` の局所化として作れる。`UniqueFactorizationMonoid` **66 件** | **配線**（作る手間であって数学的欠落ではない） |
| 補題 Q0（アルキメデス粗上界） | `Algebra.norm` **52 件** | **配線**。$\mathbb{R}$ へ脱出する唯一の箇所であることも report のとおり |
| $A_{\mathrm{gen}}$ の $L$ 非依存性（$(5.1)$） | `Projectivization` **15 件**。$\mathbb{P}^1(\mathbb{Z}/\ell^M)$ のレベル構造とファイバーの一様性を Lean 内に作っていない | **配線** |

### 8.2 mathlib に無い

| 概念 | 3 段の結果 | 判定 |
|---|---|---|
| Kirchhoff の Matrix–Tree 定理 | `matrixTree` 0 / `kirchhoff` 0 / ファイル名 0 | **無い**（cycle 21 と一致） |
| 全域木の**個数**の公式 | `numSpanningTrees` 0 / `spanning tree` 3 / ファイル名 0。3 件は `NielsenSchreier`・`Arborescence`・`Acyclic` で、いずれも全域木の**存在**であって個数ではない（中身を読んだ） | **無い** |
| Newton 多面体 | `NewtonPolytope` 0 / `newton polytope` 0 / ファイル名 0 | **無い**（cycle 21 と一致） |

したがって $\kappa_n$ の独立計算は Lean 外（Python / SageMath の Matrix–Tree + Bareiss）で行うほかない。
これは cycle 21 の `logs/ell2-matrix-tree-cycle21.log` の方針を踏襲する。

---

## 9. 自分が犯した誤り（記録）

1. **`abs_add` が存在するか確認せずに使った。** 定理 Q1 $(6.1)$ の三角不等式で `abs_add` を
   2 箇所で使ったが、この mathlib（v4.32.1 / `520045ab14e2`）には**その名前の補題が無く**、
   `Unknown identifier abs_add` でビルドが落ちた。`abs_le` に書き換えて解決した。
   **前サイクルで「mathlib に在ると書く前に検索で確認せよ」と書いたのは未形式化の理由づけについてだったが、
   同じ規律はコードを書くときにも要る。**
2. **`IsPrimitiveRoot.sub_one_norm_prime_ne_two` を確認せずに「mathlib に在る」と
   ファイル冒頭コメントへ書いた。** 検索したところ **0 件**だった。
   実在する `zeta_sub_one_prime`（3 件）へ差し替えた。
   **これは前サイクルが記録した誤りの再発である**（フレーズをファイル名検索して無意味な 0 件を出した件）。
   形は違うが、根は同じ「確認せずに書いた」である。
3. **`IsTotallyRamified` が 3 段とも 0 件だったのを、一度「完全分岐は mathlib に無い」と読みかけた。**
   実際には概念は `ramificationIdx`（16 件）/ `inertiaDeg`（15 件）で表現されており、
   **検索語の選び方が悪かっただけ**である。3 段方式は「語の綴りの不在」を「概念の不在」と
   取り違える罠を完全には塞がない（cycle 16 の Weierstrass 準備と同型の罠）ことが再確認された。
   targeted な追加検索を `logs/mathlib-gap-survey-cycle22.log` の末尾に記録した。

---

## 10. 本文（`structured-latex/`）への申し送り

**本 step は本文を一切触っていない。** cycle 22 step 1 が定理 Q1・G4 を本文へ移すときに、
以下を反映すること。

| # | 箇所 | 内容 |
|---|---|---|
| 1 | 定理 G4 §5.3 条件 2 | $M\ge r^\sharp+\max K+1$ → **$M\ge r^\sharp+\max K$**（§1.3） |
| 2 | 定理 Q1 $(6.1)$ | $C$ の $|\mathcal{B}_M|$ を補題 Q5 の上界 $r\ell^{c_1}$ へ置き換える（§2） |
| 3 | 補題 Q5 | $c_1$ の定義の $+1$ が**狭義不等式のため**であることを一言書く（§3.1） |
| 4 | 定理 G4 注 4.2 | $K$ を大きく取っても $(5.3)$$(5.4)$ が変わらない理由（打ち消し）を一言書く（§3.2） |
| 5 | 定理 Q1 の証明 | $\mathcal{B}_M$ 上でも (H) より $\tilde E(\omega_P)\ne0$ なので補題 Q0 が使える、を明示（§4） |
| 6 | 定理 G4 §6.3 | 「$n=1$ から一致」は定理の保証範囲（$n\ge M^*-1$）の外であることを明記（§5） |

---

## 11. 新規性

**主張しない。** 本 step は cycle 21 の 2 つの report の**主張の検算**であり、新しい数学は無い。
定理 Q1 の内容自体が Cuoco–Monsky (1981) Theorem 1.7 ＋ Definition 1.2 であることは
cycle 21 step 1 §11 が同定済みで、本 step はそれを追認するだけである。
