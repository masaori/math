# cycle 23 / 運用: cycle 22 の新定理群を Lean で検算する（定理 D1–D6・命題 D1a）

対象: cycle 22 step 3 で得た新定理群（`docs/tasks/auto-loop-state.md` の cycle 23 step 4）。
**目的は証明の正しさではなく、主張が一意に読めるか・仮定が過不足ないかの検査**である
（cycle 17: 誤り 1 件／18: 誤り 2 件／19: 過剰仮定 2 件／20: 誤り 1 件＋暗黙の仮定 1 件＋過剰仮定 2 件／
21: 主張の欠陥 1 件＋根拠不足 1 件＋記号の多義性 1 件＋過剰仮定 2 件／22: 内部の食い違い 1 件ほか 5 件。
**本サイクルで 8 サイクル連続**）。

前提として読んだ一次情報:
`outputs/reports/cycle22_T3_coefficients_d_e.md`（**定理 D1・命題 D1a・定理 D2–D6**、§1 の前提訂正、
§4 の 3 層階層、§7 の検証、§8 の誤り記録、§9 の障害）、
`cycle22_ops_lean_cycle21_theorems.md`（前サイクルの Lean 化）、
`cycle21_T3_general_closed_form.md` §5.1–§5.3（定理 G4 の $(5.2)$–$(5.4)$。定理 D1 の出発点）、
`lean/README.md`、`docs/tasks/auto-loop-runbook.md`。

**本 step は本文（`structured-latex/` と `structured-latex-en/`）と検査道具を一切触っていない**
（step 1・step 2 の担当。衝突回避）。成果物は `lean/`（`IntegrableLattice/CoefficientsDE.lean`）と本 report だけである。

---

## 0. 結論（先に置く）

| 検出 | 内容 | 状態 |
|---|---|---|
| **主張が偽 1 件（最大の成果）** | 定理 D2 の最後の一文「$T_\mathrm{def}=0$ であることと、閉形式 $(1.1)$ が $n\ge0$ から成り立つこととは**同値**である」の **$\Rightarrow$ 方向が偽**。$T_\mathrm{def}$ は過渡欠損の**総和**なので、$0$ でも**部分和**が $0$ とは限らない。証明本文（「$T_\mathrm{def}=0$ は $\sum_{M<M^*}(\Theta_M-\Theta^\mathrm{as}_M)=0$ を意味する。…したがって $\Sigma_n$ が全ての $n\ge0$ で漸近形と一致することと同値」）は総和から部分和へ飛んでいる | §1。Lean: `D2_residual` / `D2_equiv_forward_false` / `D2_equiv_corrected`。**正しい同値は「$\Theta_M=\Theta^\mathrm{as}_M$ が全 $M\ge1$ で成立」**。$T_\mathrm{def}=0$ 単独と同値なのは「$n=0$ **の一点で**閉形式が成り立つこと」 |
| **主張が一意に読めない 1 件** | 定理 D3 の 2 の $\Lambda_1=\min(2,v_2(p-1))$ は、**$p=1$（＝ $\ell=2$ トーラス。この定理の主役の片方）で $A_2=1-p=0$** になる。$v_2(0)=+\infty$ の規約なら $\Lambda_1=2$（証明本文が使う値）、$v_2(0)=0$ の規約（mathlib の `padicValNat` を含む標準）なら $\Lambda_1=0$ で $\mathcal{L}=1$、$c=0\ne4$ になり結論が壊れる。**規約が本文に書かれていない**。定理 D5 の $\Lambda_1=\min(v_2(4(p+t)),v_2(t-q))$ も $t=q$ で同型（$p,q,t\ge1$ 一般で述べているので $t=q$ を含む） | §2。Lean: `D3_p_eq_one_convention` |
| **境界は正しく書かれている（確認）** | 定理 D6 の $(6.1)$ が**狭義**（$N>\max\Lambda_k$）であることは必要。$N=\max\Lambda_k$ に弱めると偽になる具体例（$\ell=2$, 係数 $(4,2)$ と $(2,2)$ は $\bmod\ 2$ で同じだが $\theta^\sharp$ が $1$ と $0$ で違う）を Lean で構成した | §3。Lean: `D6_truncation` / `D6_boundary_sharp` |
| **食い違い無し** | 定理 D1 $(2.2)$$(2.3)$ が cycle 21 $(5.2)$–$(5.4)$ の書き換えとして正しいこと、$d\in\mathbb{Z}$、$S_\infty=\emptyset\Rightarrow d=-2$、命題 D1a の相殺（$\varphi(\ell^{K+1})=\ell^{K+1}-\ell^{K}$ が効く）、定理 D2 の分解そのもの、定理 D3・D5 の $y=1+x$ 代入の係数抽出、定理 D4 の合同と 4 箇所の $2$ 進付値と $\sum\mathcal{L}$ が $3$ 減ること、定理 D5 の $\theta^\sharp$ 反転、$\ell=2$ トーラスの数値 $5,19,61,167,417,987$ | §4 |
| **検証（実行ログつき）** | `lake build` **`Build completed successfully (8677 jobs).`** / `BUILD_EXIT=0`。`check-no-sorry.sh` は **267 個**（前サイクル 231 ＋ 本 step 36）すべて `sorryAx` 非依存 / `CHECK_EXIT=0` | §5 |
| **形式化しなかったもの** | mathlib の欠落（Matrix–Tree／全域木の個数／Newton 多角形／voltage グラフ）と配線（超距離的等号・円分体の付値・2 変数 Laurent 環）に分離。**「無い」と書く前に 3 段方式で検索し、0 でないヒットは中身を読んだ** | §6 |
| **自分が犯した誤り** | 3 件（未完成の主張を doc コメントに書いた／`field_simp` の後に不要な `ring` を付けた／`rw [h, h]` で無限ループ相当の no-op を書いた） | §7 |

---

## 1. 定理 D2 の最後の一文は偽である（$\Rightarrow$ 方向）

### 1.1 何が書いてあるか

report §3 の定理 D2 は、

> とくに $T_\mathrm{def}=0$ であることと、閉形式 $(1.1)$ が $n\ge0$ から成り立つこととは同値である。

と述べ、証明で

> $T_\mathrm{def}=0$ は $\sum_{M<M^*}(\Theta_M-\Theta^\mathrm{as}_M)=0$ を意味する。
> cycle 14 $(6.1)$ は $\mathrm{ord}_\ell(\kappa_n)$ を $\Sigma_n=\sum_{M\le n}\Theta_M$ で書くので、
> $\Sigma_n$ が全ての $n\ge0$ で漸近形と一致することと同値である。

と書いている。

### 1.2 Lean で分けた

$\delta_M:=\Theta_M-\Theta^\mathrm{as}_M$ と置き、部分和 $S(n):=\sum_{M=1}^{n}\delta_M$ を `Sdef` として、
**cycle 14 $(6.1)$ の左辺から $(1.1)$ の 5 係数形（$e$ の角括弧を $T_\mathrm{def}=S(M^*-1)$ としたもの）を
引いた残差**を計算した（`D2_residual`。cycle 21 の `theorem_G1` を $\Theta^\mathrm{as}$ に適用して得る）:

$$\text{（左辺）}-\text{（5 係数形）}=S(n)-T_\mathrm{def}\qquad(\text{任意の }n\ge0).$$

したがって

- **レベル $n$ で閉形式が成り立つ $\iff S(n)=T_\mathrm{def}$。**
- $n=0$ では $S(0)=0$ なので、**$n=0$ で成り立つ $\iff T_\mathrm{def}=0$**（ここまでは report のとおり）。
- **全ての $n\ge0$ で成り立つ $\iff$ $S$ が定数 $T_\mathrm{def}$ $\iff$ $T_\mathrm{def}=0$ かつ
  $\delta_M=0$ が全 $M\ge1$**（`D2_equiv_corrected`）。

**総和 $T_\mathrm{def}=0$ から部分和 $S(n)=0$ は出ない。** 反例（`D2_equiv_forward_false`）:
$\Theta^\mathrm{as}\equiv0$（$\alpha=\beta=\gamma=0$）、$\Theta_1=1$、$\Theta_2=-1$、$\Theta_M=0\ (M\ge3)$。
$M^*=3$ で $T_\mathrm{def}=0$ だが $S(1)=1$ なので、`D2_residual` より **$n=1$ で閉形式は $1$ だけずれる**。

### 1.3 射程の限定（正直に書く）

この反例は **$\Theta$ を任意に取った場合**のものであり、「実在の塔で $\delta$ の符号が混ざる例」を
示したものではない。したがって厳密に言えるのは次の 2 つである。

1. **report の証明は成り立たない**（総和から部分和への飛躍がある）。
2. **主張は追加の仮定なしには偽である**（$\delta_M$ が全て同符号、というような条件が要る）。
   report にはそのような条件は書かれていない。

実在の塔で $\delta$ の符号が混ざるかは本 step では確かめていない。ただし report §7.2 は
$T_\mathrm{def}=0$ の塔を 108 本挙げており、主張が真ならその 108 本すべてで $n=0$ から閉形式が
成り立つことになる。これは検証されていない（Step E は $n\ge n_0$ の照合であり、
$n<n_0$ でずれた 48 件を「理論の射程外」として除いている）。

### 1.4 訂正案

> とくに $T_\mathrm{def}=0$ であることは、閉形式 $(1.1)$ が **$n=0$ で**成り立つことと同値である。
> $(1.1)$ が**全ての $n\ge0$ で**成り立つことは、$\Theta_M=\Theta^\mathrm{as}_M$ が全ての $M\ge1$ で
> 成り立つこと（過渡が一切無いこと）と同値であり、これは $T_\mathrm{def}=0$ より真に強い。

---

## 2. 定理 D3 の 2 は $p=1$ で字義どおりには読めない

定理 D3 の 2 は、奇数 $p$ について

$$\Lambda_1=\min\bigl(2,\,v_2(p-1)\bigr)$$

と書く。証明の中で $A_0=A_1=4$、$A_2=1-p$ を計算し、$\Lambda_1=\min(v_2(4),v_2(1-p))$ としているので、
この $v_2(p-1)$ は **$A_2$ の付値**である。

**ところが $p=1$ では $A_2=1-p=0$ である。** そして $p=1$ は本定理の主役の片方
（$\ell=2$ トーラス。$(a,b,c,d,e)=(0,2,4,-6,-1)$ を出す側）である。

- $v_2(0)=+\infty$ と読めば $\Lambda_1=2$、$\mathcal{L}=v_2(2)+2=3$、$c=2\cdot3-2=4$ で
  証明本文・検証と整合する（report §5.1 の証明 3 はこの値を使っている）。
- $v_2(0)=0$ と読めば（**mathlib の `padicValNat` を含む、有限値へ落とす標準の規約**）
  $\Lambda_1=0$、$\mathcal{L}=1$、$c=0$ となり、$c=4$ が壊れる。

`D3_p_eq_one_convention` はこの分岐を型に出したものである（`min 2 (padicValNat 2 0) = 0 ≠ 2`）。

**要するに「$\min$ は $A_m\ne0$ の $m$ についてのみ取る（$0$ の付値は $+\infty$）」という規約が
本文に書かれていないため、主張が一意に読めない。** $\Lambda_k$ の定義（cycle 21 定理 G2）に
遡ればこの規約であることは読めるが、定理 D3 の 2 は**それ単体で読まれる形の主張**として書かれている。

**同型の問題が定理 D5 にもある。** 定理 D5 は $p,q,t\ge1$ 一般について
$\Lambda_1=\min(v_2(4(p+t)),v_2(t-q))$ と述べており、**$t=q$ のとき $A_2=0$** になる。
具体化（$t=1$, $q=1+2^{N+2}$）では $t\ne q$ なので結論は無事だが、述べ方は同じ穴を持つ。

**訂正案**: 両定理の該当箇所に「ここで $\min$ は $A_m\ne0$ となる $m$ についてのみ取る
（$v_2(0)=+\infty$）。$p=1$ では $A_2=0$ なので $\Lambda_1=2$ である」を添える。

---

## 3. 定理 D6 の $(6.1)$ が狭義であることは必要である（確認）

step の指示は「定理 D6 は『$N>\max\Lambda_k$ なら決まる』という十分条件の主張なので、
境界（等号のとき）が正しく書かれているかを型で確かめる価値が高い」だった。**結論: 正しい。**

`D6_truncation` は定理 D6 の中身——**切り捨て付き付値列 $\bigl(\min(v_\ell(A_m),N)\bigr)_m$ が
$\tilde E\bmod\ell^{N}$ で決まり、$\Lambda_k<N$ ならそこから $\Lambda_k$（最小値）も
$\theta^\sharp_k$（最小を最初に達成する添字）も読める**——を、付値を $\mathbb{N}$ 値の
抽象関数として型に出したものである。仮定を最小化すると、要るのは

- 切り捨て列の一致（$\forall m,\ \min(v_m,N)=\min(v'_m,N)$）、
- **$v_{m_0}<N$**（＝ $(6.1)$）、
- $m_0$ が最小を最初に達成すること

の 3 つだけで、$K$・$j^*$・$e_{j^*}$・$r^\sharp$ が第 1 層から決まることは別途要る（report のとおり）。

`D6_boundary_sharp` は、**$v_{m_0}<N$ を $v_{m_0}\le N$ に弱めると定理が偽になる**ことを示す。
反例は $\ell=2$、$N=1$、係数 $A=(4,2)$（付値 $(2,1)$）と $A'=(2,2)$（付値 $(1,1)$）:
$A-A'=(2,0)$ はすべて $2^{1}$ の倍数なので $\bmod\ 2^{N}$ では区別できないが、
$\Lambda=1=N$ で、最小を最初に達成する添字は $1$ と $0$ で違う（**$\theta^\sharp$ が違う**）。

すなわち report の $(6.1)$ の書き方（狭義）は正しく、等号を含めてはならない。
注 6.1 の「$N$ を 1 ずつ上げて、最小値が $N$ **未満**であることを確認する」という運用も、
この狭義性と整合している。

---

## 4. 食い違いが無かったところ

### 4.1 定理 D1（`D1_d_formula` / `D1_c_bracket` / `D1_c_alpha_term`）

- $(2.2)$ は cycle 21 $(5.4)$ ＋ $d=\gamma-2$ の書き換えとして正しい。
  **右辺に $\Lambda$ も $A_\mathrm{gen}$ も $v_\ell(\kappa(X))$ も現れない**ことが型で読める（主張 1）。
- $(2.3)$ は $(5.3)$ に $\frac{\ell}{\ell-1}$ を掛けた形と、$(5.2)$ を
  $-\frac{\ell}{(\ell-1)^2}\alpha$ に入れて $-\frac{\sum j^*}{\ell-1}$ に潰した形の和で、
  report の式に一致する。$\Lambda$ が $c$ にだけ、$\theta^\sharp$ が $d$ にだけ入る（主張 3）ことも型で読める。
- $d\in\mathbb{Z}$（主張 2）は `D1_d_integer` で $\mathcal{T},e_{j^*}\in\mathbb{Z}$ からの帰結として、
  $S_\infty=\emptyset\Rightarrow d=-2$（主張 4）は `D1_d_empty` で確認した。

### 4.2 命題 D1a（`totient_step` / `D1a_d_invariant` / `D1a_c_invariant` / `D1a_Lambda_step`）

$K\to K+1$ の相殺は report の計算どおりである。$d$ 側で効くのは
**$\varphi(\ell^{K+1})=\ell^{K+1}-\ell^{K}$**（$\ell$ 素数。`Nat.totient_prime_pow` から `totient_step`）で、
$c$ 側で効くのは $\varphi(\ell^{K+1})\Lambda_{K+1}=j^{*}$ である。どちらも差し引き $0$。

### 4.3 定理 D2 の分解（`D2_residual` / `Tdef_Mstar_indep`）

$e=v_\ell(\kappa(X))-a-c+T_\mathrm{def}$ そのもの（cycle 21 $(2.3)$ の角括弧 $=T_\mathrm{def}$）は正しい。
$T_\mathrm{def}$ の $M^*$ 非依存性も通った。**偽なのは §1 の最後の一文だけである。**

### 4.4 定理 D3・D4・D5 の手計算（`expand_at_one_plus_x` ほか）

- $y=1+x$ 代入の係数抽出（$c_2y^2+c_1y+c_0\mapsto(c_2+c_1+c_0,\,2c_2+c_1,\,c_2)$）は
  定理 D3（$A_0=A_1=4$, $A_2=1-p$）でも定理 D5（$A_0=A_1=4p+4t$, $A_2=t-q$）でも report のとおり。
- 定理 D3 の $d=2\theta^\sharp_1-6$、角括弧 $=\mathcal{L}-3$、$c=2\mathcal{L}-2$、
  $p=1,3$ での $(c,d)=(4,-6),(4,-2)$、$e=-1,-4$ もそのまま通った。
- $\ell=2$ トーラスの閉形式 $2n2^n+4\cdot2^n-6n-1$ が $5,19,61,167,417,987$ を再現することも確認した。
- 定理 D4: $t'-t=2^{N}$（`D4_congruence`）、$v_2(t+1)=N+1$・$v_2(t'+1)=N$・$v_2(t\mp1)=1$
  （`D4_valuations`。$N\ge2$ で成立し、$N=1$ では最後が破れる——report §7.2 の注記と整合）、
  $\sum\mathcal{L}$ がちょうど $3$ 減ること、**$\theta^\sharp$ が不変なら $d$ が不変**であること
  （`D4_d_invariant`。「定理 D4 は $c$ の障害であって $d$ の障害を含まない」）。
- 定理 D5: $\Lambda_1$ が $N+2$ のまま**不変**で $\theta^\sharp_1$ だけが $2\to0$ に動くこと
  （`D5_theta_flip`）と、1 点の $\mathcal{T}$ が $2$ 減ると $d$ がちょうど $2$ 減ること（`D5_d_shift`）。

---

## 5. 検証（`lake build` と `check-no-sorry.sh`）

### 5.1 実行前の負荷の扱い

cycle 23 step 列の申し送りに従い、**負荷平均ではなく `top` の CPU idle** を見た。
着手時は `Load Avg: 7.83 12.38 39.07` / **`CPU usage: 24.38% user, 17.55% sys, 58.5% idle`**。
idle が 6 割近いのでそのまま着手した。

### 5.2 結果（内訳つき。**すべて本 step の実行ログが一次情報**）

| 項目 | 結果 |
|---|---|
| `lake exe cache get` | `Decompressed 8638 already-cached file(s)` / `No files to download` / `Completed successfully in 50882 ms!` / `CACHE_EXIT=0`（`logs/cache-get-cycle23.log`） |
| `lake build` | **`Build completed successfully (8677 jobs).`** / `BUILD_EXIT=0`（`logs/build-cycle23-D.log`） |
| `bash scripts/check-no-sorry.sh` | ソース中に `sorry` / `admit` 無し。列挙した **267 個**の定理がすべて `sorryAx` 非依存 / `CHECK_EXIT=0`（`logs/check-no-sorry-cycle23.log`） |
| 依存公理の内訳 | `[propext, Classical.choice, Quot.sound]` **205**（うち 3 個は出力が折り返されている）、`[propext, Quot.sound]` **32**、`[propext]` **27**、公理なし **3**（合計 267）。`sorryAx` は **0** |
| 本 step で追加した 36 個の内訳 | `[propext, Classical.choice, Quot.sound]` **30**、`[propext, Quot.sound]` **4**、`[propext]` **2** |

### 5.3 前サイクルの数値との突き合わせ

- **jobs**: 本 step は新規モジュールを **1 本**（`CoefficientsDE`）追加した。$8677-1=8676$ で、
  **cycle 22 step 4 が報告した 8676 jobs と一致する**。
- **定理数**: `check-no-sorry.sh` の `targets` に **36 個**追加した。$267-36=231$ で、
  **cycle 22 step 4 が報告した 231 個と一致する**。267 個すべてが `sorryAx` 非依存で通っているので、
  **cycle 22 の 231 個も本 step で独立に再確認されている**。
- `check-no-sorry.sh` の差分は **`targets` への 36 行の追加だけ**（検査方式は変えていない）。

### 5.4 依存の復旧について

worktree には `.lake` が無いので mathlib の取得から始めた。**今回は途中で壊れなかった**
（`lake exe cache get` 一発で `CACHE_EXIT=0`）ので `.lake/packages/mathlib` の消去・再取得は不要だった。
**`lake update` は実行していない。`git status lake-manifest.json` は空**であり、
**依存の revision は変わっていない**（mathlib `520045ab14e26149ee970e2e617ca04b09bde5d6` / `leanprover/lean4:v4.32.1`）。

### 5.5 壁時計

`lake exe cache get` 50.9 s（クローン込みの実測は別。バックグラウンドで先行実行した）、
`lake build` は cache 済み前提で 1 回目 8673/8677 まで進んで失敗、修正後に完走。
**`lake build` は設計要件の 20 分上限の例外**（step 指示のとおり）。それ以外に長時間スクリプトは走らせていない。

---

## 6. 形式化しなかったもの（mathlib の欠落か配線か）

一次情報は `lean/logs/mathlib-gap-survey-cycle23.log`（3 段方式 + targeted 追加）。
**「無い」と書く前に必ず語幹 grep・内容 grep・ファイル名検索を行い、0 でないヒットは中身を読む**
という cycle 16 以来の規約に従った（cycle 21・22 の 2 サイクル連続でこの規約違反が記録されているため、
本 step では report を書く前に検索を済ませた）。

### 6.1 配線（mathlib に在るが繋いでいない）

| 未形式化の箇所 | mathlib の状況 | 判定 |
|---|---|---|
| 定理 D6 の付値の非アルキメデス的等号（$v(A+\ell^N\beta)=v(A)$ when $v(A)<N$） | **在る**。`Valuation.map_add_eq_of_lt_left` / `map_add_eq_of_lt_right`（`Mathlib/RingTheory/Valuation/Basic.lean:304,307,1240,1244`）、`padicValRat.add_eq_of_lt`（`Padics/PadicVal/Basic.lean:329`）。本 step は付値を $\mathbb{N}$ 値の抽象関数に置き換えて `min` の算術として通した（`D6_truncation`） | **配線** |
| $\Lambda_k,\theta^\sharp_k$ の定義（$\mathcal{O}_k=\mathbb{Z}[\zeta_{\ell^k}]$ 上の付値） | `IsCyclotomicExtension` **442 件**、`zeta_sub_one_prime` **30 件** | **配線**（cycle 22 と同じ判定） |
| $\tilde E$（2 変数 Laurent 多項式）そのもの | `Polynomial.Laurent` は **在る**（3 件。1 変数）。`MvPolynomial.Laurent` は **0 件**だが `MvPolynomial` の局所化として作れる | **配線** |

### 6.2 mathlib に無い

| 概念 | 3 段の結果 | 判定 |
|---|---|---|
| Kirchhoff の Matrix–Tree 定理 | `matrixTree` 0 / `kirchhoff` 0 / 内容 `matrix tree` 0 / `Kirchhoff` 0 | **無い**（cycle 21・22 と一致） |
| 全域木の**個数** | `numSpanningTrees` 0 / 内容 `spanning tree` **7 件**。7 件は `NielsenSchreier`(4)・`Arborescence`(1)・`Acyclic`(2) で、いずれも全域木の**存在**（連結グラフは全域木を持つ／非輪状部分グラフは拡張できる）であって**個数ではない**（中身を読んだ） | **無い** |
| Newton 多角形 | `NewtonPolytope` 0 / 内容 `newton polygon` 0 / ファイル名 `*Newton*` **2 件**は `Dynamics/Newton.lean`（Newton 法）と `MvPolynomial/Symmetric/NewtonIdentities.lean`（Newton の恒等式）で**別物**（中身を読んだ） | **無い**（cycle 21・22 と一致） |
| voltage グラフ | `voltageGraph` 0 / 内容 `voltage` 0 | **無い** |

したがって $\kappa_n$ の独立計算（Matrix–Tree）と $\tilde E=\det L(z,w)$ の構成は Lean 外
（SageMath）で行うほかない。cycle 21・22 の方針を踏襲する。

### 6.3 report 自身が「取れていない」と書いているもの（本 step でも取っていない）

- $e$ の必要精度の明示形（§9.1）、$T_\mathrm{def}$ の局所分解（§9.2）、階数 3 以上（§9.3）、
  $\max\Lambda_k$ の $D$ の係数からの上界（§9.4）、定理 D4・D5 の奇素数版（§11 の 4）。
  いずれも数学的に未解決の側であり、mathlib の欠落でも配線でもない。

---

## 7. 自分が犯した誤り（記録）

1. **未完成の主張を doc コメントに書いた。** 初稿で `D1_c_formula`（$S_\infty$ 上の和のレベルで
   $(2.3)$ を出す形）を書こうとして代数を詰め切れず、本体に `sorry` を 2 つ残したまま、
   ファイル冒頭の「形式化した主張」欄には **`D1_c_formula` — 定理 D1 $(2.3)$** と完成した体で書いていた。
   ビルドで落ちたので気づいた。是正として、和のレベルの主張をやめ、**点ごとの
   `D1_c_bracket` と $\alpha$ 項の `D1_c_alpha_term`**（report の証明が実際にやっている分解）へ
   組み替え、コメントも実体に合わせた。
   **「主張を先に書いて中身を後から埋める」書き方は、埋まらなかったときに嘘の記述が残る。**
2. **`field_simp` の後に不要な `ring` を付けた。** 2 箇所で `No goals to be solved` になった。
   タクティクの効果を確認せずに定型（`field_simp; ring`）を貼った。
3. **`rw [h, h]` と書いた。** `h : ∀ n, Sdef n = Sdef ms` に対して 2 回目の `rw` が
   `Sdef ms` を `Sdef ms` に書き換える no-op になり、目標が閉じなかった。
   `rw [h (k+1), h k]` と引数を明示して解決した。

なお **cycle 21・22 が 2 サイクル連続で記録した「mathlib に在る／無いを確認せずに書いた」は、
本 step では起きていない**（§6 の判定はすべて本 step の検索ログに基づく。使った補題
`Nat.totient_prime_pow`・`Finset.add_sum_erase`・`padicValNat` はいずれもビルドが通ることで実在が確認済み）。

---

## 8. 根拠 report への申し送り

**本 step は本文も根拠 report も触っていない。** 反映担当（cycle 23 step 1 以降）は以下を織り込むこと。

| # | 箇所 | 内容 |
|---|---|---|
| 1 | `cycle22_T3_coefficients_d_e.md` §3 定理 D2 の最後の一文 | 「$T_\mathrm{def}=0\iff n\ge0$ から閉形式」は**偽**。$T_\mathrm{def}=0$ と同値なのは「$n=0$ で閉形式が成り立つこと」。全 $n\ge0$ と同値なのは「$\Theta_M=\Theta^\mathrm{as}_M$ が全 $M$」（§1.4 の訂正案） |
| 2 | 同 §5.1 定理 D3 の 2 | $\min$ は $A_m\ne0$ の $m$ についてのみ取る規約を明記する。とくに $p=1$ では $A_2=0$ なので $\Lambda_1=2$ であることを書く（§2） |
| 3 | 同 §6.2 定理 D5 | 同じ規約を明記する（$t=q$ で $A_2=0$）。$p,q,t\ge1$ 一般で述べているため（§2） |
| 4 | 同 §3 注 3.1 | $T_\mathrm{def}=0$ の塔 108 本について「閉形式が $n=0$ から成り立つ」と読める書き方をしていないか確認する（1 が直れば自動的に整合する） |

---

## 9. 新規性

**主張しない。** 本 step は cycle 22 の report の**主張の検算**であり、新しい数学は無い。
検出した 2 件（定理 D2 の最後の一文・定理 D3/D5 の $\min$ の規約）はいずれも
既存の主張の書き方の問題であって、新しい定理ではない。

---

## 10. 検証コード

`lean/IntegrableLattice/CoefficientsDE.lean`（36 定理）。実行ログは
`lean/logs/cache-get-cycle23.log` / `build-cycle23-D.log` / `check-no-sorry-cycle23.log` /
`mathlib-gap-survey-cycle23.log`。
