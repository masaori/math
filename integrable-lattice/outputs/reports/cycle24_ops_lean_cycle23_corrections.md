# cycle 24 / 運用: 訂正後の D 系列と未検算の定理群を Lean で検算する

対象: `docs/tasks/auto-loop-state.md` の cycle 24 step 5（`lean_cycle24`）。Lean 化の **9 サイクル目**。
（cycle 17: 誤り 1 件／18: 誤り 2 件／19: 過剰仮定 2 件／20: 誤り 1 件＋暗黙の仮定 1 件＋過剰仮定 2 件／
21: 主張の欠陥 2 件＋過剰仮定 2 件／22: 内部矛盾 1 件＋明示性 1 件＋根拠不足 2 件＋暗黙の仮定 1 件／
23: **主張が偽** 1 件＋一意に読めない 1 件。）

**本 step が触ったもの**: `lean/IntegrableLattice/Cycle24Corrections.lean`（新規）、
`lean/IntegrableLattice.lean`（import 1 行）、`lean/scripts/check-no-sorry.sh`（対象定理の追加のみ。
検査を緩めていない）、`lean/scripts/mathlib-gap-survey-cycle24.sh`（新規）、`lean/logs/`、本 report。
指示どおり **本文（`structured-latex/content/`）・`structured-latex-en/`・`structured-latex/tools/`・
`docs/tasks/auto-loop-state.md`・`MEMORY.md` は一切触っていない。既存 report の訂正もしていない。**
push 先は現在の worktree ブランチだけで、**`main` へは push していない**（逸脱ログ 2026-07-31 の 2 件）。

前提として読んだ一次情報: `CLAUDE.md`、`integrable-lattice/README.md`、`docs/tasks/auto-loop-runbook.md`、
`docs/tasks/auto-loop-state.md`（cycle 24 step 列・cycle 23 総括・**逸脱ログ**）、
**過去 4 サイクルの Lean 検算 report の「自分の誤り」節**
（`cycle20` §7・`cycle21` §9・`cycle22` §9・`cycle23` §7）、
`cycle24_ops_fix_grounding_reports.md`、および **step 1 が訂正した後の**
`cycle22_T3_coefficients_d_e.md` §2.3・§3・§5.1・§6.2、
`cycle21_T3_general_closed_form.md` §3・§4 注 4.2・§5.2・§5.3・§5.5・§6.1、
`cycle21_T3_drop_assumption_B_star.md` §5.2・§6、
既存の `lean/IntegrableLattice/`（とくに `CoefficientsDE.lean` / `GeneralTowerClosedForm.lean` /
`DropAssumptionBStar.lean`）と `lean/README.md`。

---

## 0. 結論（先に置く）

| 何を | 結果 | 節 |
|---|---|---|
| **cycle 22・23 の指摘 6 件を訂正が塞いだか** | **すべて塞がった。** 訂正後の主張をそのまま形式化して 6 件とも通った | §1 |
| **訂正が「塞ぎすぎ／塞ぎ足りない」箇所** | 定理 D2 の訂正は **cycle 23 の Lean 版より精密**（$T_\mathrm{def}=0$ は連言ではなく帰結）。定理 G4 §5.3 は条件 2 だけでなく**条件 1–5 すべてが §6.1 と整合する**ことまで確認 | §1.1 / §1.3 |
| **新たに検出した問題** | **2 件**。(a) 補題 Q5 の $c_1$ が **$b=0$ で定義されない**（$S_\infty=\emptyset$ ＝系 G6 がまさにその場合）。(b) 定理 G2 $(3.2)$ の $m^\sharp_k=\infty$ の読み方が本文に無い（**訂正した D3/D5 と同じ型の穴**。ただし実害なし） | §2 |
| **新たに通した定理** | **系 G6**（$S_\infty=\emptyset$ の 5 係数）と **系 Q7**（$\ell=2$ トーラスの $b=2$ の標数 2 因数分解）。選んだ理由は §3 | §3 |
| **副産物（本 step の観察）** | 補題 Q5 の $c_1$ の**実対数は除去できる**。$\mathbb{N}$ 上の決定可能な最小元で取れば ℝ 脱出も $b=0$ の縮退も同時に消える | §2.1 |
| **検証** | `lake build` **8678 jobs**（cycle 23 の 8677 ＋ 新規 1 モジュール）、`check-no-sorry.sh` **294 定理**すべて sorryAx 非依存（cycle 23 の 267 ＋ 本 step の 27） | §4 |
| **自分が犯した誤り** | 3 件（うち 1 件は **cycle 23 が記録済みの誤りの再発**） | §6 |

**新規性は主張しない。** 本 step は既存の主張の検算である。

---

## 1. 訂正は指摘を塞いだか（6 件すべて塞がった）

方法は「訂正後の主張をそのまま形式化して通す。通らなければ訂正が不十分」。
以下いずれも通った。形式化は `lean/IntegrableLattice/Cycle24Corrections.lean`。

### 1.1 定理 D2 の最後の一文（cycle 23 が「偽」と判定した箇所）— 塞がった。**しかも訂正のほうが精密**

訂正後の `cycle22_T3_coefficients_d_e.md` §3 は 3 分岐で書かれている。3 つとも型に出した。

| 訂正後の主張 | Lean | 結果 |
|---|---|---|
| レベル $n$ で $(1.1)$ が成り立つ $\iff S(n)=T_\mathrm{def}$ | `D2_level_iff` | 通った |
| $(1.1)$ が $n=0$ で成り立つ $\iff T_\mathrm{def}=0$ | `D2_level_zero_iff` | 通った |
| 全ての $n\ge0$ で成り立つ $\iff \delta_M=0\ (\forall M\ge1)$ | `D2_all_iff_no_transient` | 通った |
| （このとき $T_\mathrm{def}=0$ も従う） | `D2_no_transient_imp_Tdef_zero` | 通った |

いずれも cycle 23 の `D2_residual`（差が $S(n)-T_\mathrm{def}$ であること）から出る。
偽だった $\Rightarrow$ 方向の反例（cycle 23 の `D2_equiv_forward_false`）は訂正後の主張と両立する。

**訂正のほうが cycle 23 の Lean より精密である。** cycle 23 の `D2_equiv_corrected` は右辺を
「$T_\mathrm{def}=0$ **かつ** 過渡が無い」という**連言**で書いていたが、
$T_\mathrm{def}=0$ は後者の帰結なので連言の片方は不要である（`D2_all_iff_no_transient` は
連言なしで同値を出す）。訂正後の report が $T_\mathrm{def}=0$ を括弧に落として
「（このとき $T_\mathrm{def}=0$ も従う）」と書いているのは、この意味で**正確**である。

**射程の限定**: 塞がったのは「主張が偽である」という欠陥である。
$T_\mathrm{def}=0$ の実在の塔 108 本について $(1.1)$ が $n=0$ で成り立つかは、
訂正後の report §2 が自分で「まだ検証されていない」と書いているとおり**未検証**であり、
本 step でも検証していない（sagemath 側の作業）。

### 1.2 定理 D3 の 2・定理 D5 の $v_\ell(0)=+\infty$ 規約（cycle 23 が「一意に読めない」と判定）— 塞がった

訂正は「$\min$ は $A_m\ne0$ の $m$ についてのみ取る（$v_2(0)=+\infty$）」を明記した。
これを型に出すには付値を $\mathbb{N}\cup\{\infty\}$ に取ればよい（`LamC` / `thC`）。

| 訂正後の主張 | Lean | 結果 |
|---|---|---|
| $p=1$: $A=(4,4,0)$ で $\Lambda_1=2$, $\theta^\sharp_1=0$ | `D3_conv_p_eq_one` | 通った |
| $p\ne1$: $\Lambda_1=\min(2,v_2(p-1))$、$\theta^\sharp_1$ は $v_2(p-1)\ge2$ で $0$、$=1$ で $2$ | `D3_conv_p_ne_one` | 通った |
| $t=q$: $\Lambda_1=v_2(4(p+t))$, $\theta^\sharp_1=0$ | `D5_conv_t_eq_q` | 通った |
| $p=1$ で $c=2\mathcal{L}-2=2\cdot3-2=4$ が復旧する | `D3_conv_c_p_eq_one` | 通った |
| 旧規約（$v_2(0)=0$）では $c=0\ne4$ のまま | `D3_old_conv_c_broken` | 通った |

**すなわち規約の明記は必要かつ十分である。** cycle 23 の `D3_p_eq_one_convention`（$\min(2,0)=0\ne2$）は
訂正後の読み方では発生しない。

**ついでに分かったこと**: **この規約は cycle 21 の定理 G2 では既に型に出ていた**
（`twisted_unique_min` の `supp m`＝ $A^{[k]}_m\ne0$）。落ちていたのは、
cycle 22 の定理 D3・D5 が同じ規約を引き継がなかったことである。
**同じ report 群の中で規約が伝わらなかった**のが原因であって、規約そのものが新しかったわけではない。

### 1.3 定理 G4 §5.3 の条件 2（cycle 22 が「内部矛盾」と判定）— 塞がった。**条件 1–5 すべてで確認した**

訂正は $M\ge r^\sharp+\max K+1$ から $+1$ を落とした。

- `G4_cond2_corrected_at_61`: §6.1 の $(r^\sharp,K,M^*)=(1,0,1)$ は
  **訂正後の条件 2 を満たし、初稿の条件 2 を満たさない**。層が空（$M=r^\sharp+K$）でも
  (b) の閉形式は両辺 $0$ で成り立つ（`G4_cond2_empty_layer_ok`）。
- **条件 2 だけを見て「塞がった」としていない。** §6.1 が $M^*=1$ を使うには条件 1–5 の**すべて**が
  要る。$\ell\ge3$、$L=1$, $r^\sharp=1$, $K=0$, $\theta^{\max}_U=2$, $e_{j^*}=j^{*}=1$ を入れて
  条件 1・2・3・5 を数値で確認した（`G4_cond_all_at_61`）。条件 4 は $k=0$ のみで、
  §6.1 の塔では $\Phi_u=-\ell x^{2}$ すなわち $A_0=A_1=0$ なので $m^\sharp_0=\infty$ となり
  $(3.2)$ は自動的に成立する（`G2_cond32_sum_form_top`）。
  **したがって §5.3 と §6.1 の食い違いは完全に消えた。**

### 1.4 注 4.2 の打ち消し計算（cycle 22 が「根拠不足」と判定）— 塞がった

訂正で書き足された計算を両側とも型に出した。

- $(5.4)$ 側: `G4_note42_d_side_totient`。cycle 22 の `G4_K_dependence` は $\varphi(\ell^{K+1})$ を
  $\ell^{K+1}-\ell^{K}$ と**先に置き換えた形**だったが、本 step は `Nat.totient` のまま扱い、
  $\ell$ が素数であること（`CoeffsDE.totient_step`）を経由させた。
- $(5.3)$ 側: `G4_note42_c_side`。**これは初稿にも cycle 22 の Lean にも無かった側**である。
  訂正で書き足された $\frac{(\ell-1)j^{*}}{\ell}$ の相殺がそのまま通った。

### 1.5 補題 Q5 の狭義不等式（cycle 22 が「根拠不足」と判定）— 塞がった（ただし §2.1 の留保つき）

訂正は「$c_1$ の $+1$ は狭義不等式 $2b<(\ell-1)\ell^{c_1}$ のために要る」を書き足した。
その導出（$c_1\ge1+\log_\ell\frac{2b}{\ell-1}$ から $(\ell-1)\ell^{c_1}\ge2b\ell>2b$）を
`Q5_c1_strict_of_logb` として型に出した。**$\max(0,\cdot)$ を挟んでも $c_1\ge1+\log_\ell(\cdot)$ は
保たれる**（$\max(0,x)\ge x$）ので、訂正の導出は $\max$ の枝でも正しい。

**ℝ 脱出の明示**: これが本ファイルで**唯一 ℝ へ脱出する箇所**である（`Real.logb` / `Real.rpow_logb`）。
脱出の出どころは Lean ではなく **report の $c_1$ の定義そのもの**である。§2.1 で除去できることを示す。

### 1.6 定理 Q1 の「明示定数 $C$」（cycle 22 が「明示定数でない」と判定）— 塞がった

訂正後の $(6.1)$ は
$C=b\bigl(3+r\ell^{c_1}\bigr)+\theta_G^{\max}\frac{\ell+1}{\ell}+r\ell^{c_1}\log_\ell C_0$。
**cycle 22 の `theorem_Q1_error` は $\theta_G^{\max}$ の係数を $2$ に緩めていた**ので、
訂正後の report が書いている $\frac{\ell+1}{\ell}$ **そのもの**で組み直した（`Q1_C_corrected`）。
$|\mathcal{B}_M|$ を $r\ell^{c_1}$ で置き換えてよい根拠（$b\ge0$ と $\log_\ell C_0\ge0$）も仮定として型に出ている。
**訂正が明示した「$\log_\ell C_0\ge0$ に注意」は、置き換えの正当性に実際に効いている。**

### 1.7 補題 Q0 の非零性（cycle 22 が「暗黙の仮定」と判定）— 塞がった（型の上では既に済んでいた）

訂正は「(H) $\Rightarrow\kappa_n\ne0\Rightarrow\Sigma_n$ 有限 $\Rightarrow\mathcal{B}_M$ でも $\tilde E(\omega_P)\ne0$」を
証明に明示した。Lean 側では cycle 22 の `theorem_Q1_error` の仮定 `hhat`
（$\mathcal{B}_M$ 上の和が**有限の上界を持つ**）がこれを要求しており、本 step の `Q1_C_corrected` も同じである。
**訂正は、型が既に要求していたものを本文に書き下した**という関係になっている。

---

## 2. 本 step が新たに検出した問題（2 件）

**本文も既存 report も直していない**（指示どおり）。次サイクルの step 1 の対象にすること。

### 2.1 補題 Q5 の $c_1$ は $b=0$ で定義されない（**新規・実質的**）

- **何が問題か**: 定理 Q1 は仮定 (H) だけを置き、$b=\sum_{P\in S_\infty}j^{*}(P)$ に下限を課していない。
  ところが補題 Q5 の $c_1:=\max\bigl(0,\lceil1+\log_\ell\frac{2b}{\ell-1}\rceil\bigr)$ は
  **$b=0$ のとき $\log_\ell 0$ を含み、定義されない**。
  訂正で書き足された導出も $\ell^{\log_\ell t}=t$（`Real.rpow_logb`、仮定 $0<t$）を使うので、
  $b=0$ では**導出そのものが使えない**。
- **$b=0$ は実在する場合である。** 同じ cycle 21 の **系 G6 が $S_\infty=\emptyset$ の場合**を扱っており、
  そこでは $b=0$（$\alpha=0$）である。すなわち縮退は仮想的ではない。
- **cycle 24 step 1 の訂正はこの場合に触れていない。** 訂正は $+1$ の役割を書き足しただけである。
- **結論自体は無害**（$b=0$ なら $\beta_P\le b\ell^{\rho}=0$ なので $\varphi(\ell^M)>\theta_G^{\max}$ の下で
  $\mathcal{B}_M=\emptyset$）。壊れているのは**定数の定義**であって不等式ではない。
  `Q5_logb_junk_at_b_zero` に、mathlib が `Real.log 0 = 0` という**ジャンク値**を返すので
  式が黙って「動いて」しまうことを型に出した（$c_1$ が $1$ になるが、その値に根拠は無い）。
- **除去できる**（本 step の観察）。補題 Q5 が実際に使うのは狭義不等式 $2b<(\ell-1)\ell^{c_1}$ **だけ**である
  （`DropBStar.lemma_Q5_rho_max` の仮定）。そこで $c_1$ を
  **「$2b<(\ell-1)\ell^{c}$ を満たす最小の自然数 $c$」**と定義すれば、
  - 実対数も切り上げも要らない（**ℝ 脱出が消える**。`Q5_c1_exists_nat` / `Q5_c1_nat_least`）、
  - $b=0$ の縮退も消える（`Q5_c1_zero_b`: $c_1=0$ が条件を満たす）、
  - 述語は $\mathbb{N}$ 上で**決定可能**なので `Nat.find` で最小元が取れる。

  **これはプロジェクトの方針（可算で決定可能・ℝ 脱出の隔離）と直接合致する改善である。**

### 2.2 定理 G2 $(3.2)$ の $m^\sharp_k=\infty$ の読み方が本文に無い（**新規・軽微**）

- `cycle21_T3_general_closed_form.md` §3.2 は $m^\sharp_k$ を「そのような $m$ が無ければ $\infty$」と
  定義しながら、$(3.2)$ を $\varphi(\ell^{M})>\bigl(\theta^\sharp_k-m^\sharp_k\bigr)\varphi(\ell^{k})$ と
  **差の形**で書いている。**$\theta^\sharp_k-\infty$ をどう読むかは本文に無い。**
  これは **cycle 23 が定理 D3・D5 について挙げ、cycle 24 step 1 が訂正したのと同じ型の穴**である
  （無限大を含む量の演算の規約が書かれていない）。**同じ report の中に残っている。**
- **実害は無い。** $\mathbb{N}$ の切り捨て引き算で $0$ と読んでも、$-\infty$ と読んでも、
  条件は「常に真」になり**両方の読みが一致する**（$m^\sharp_k<\theta^\sharp_k$ が定義なので、
  有限のときは差が正）。**したがって §1.2 と違い、結論が壊れる読み方は存在しない。**
- 証明が実際に使っている形は $\frac{\varphi(\ell^M)}{\varphi(\ell^k)}+m^\sharp_k>\theta^\sharp_k$（和の形）で、
  こちらなら $m^\sharp_k=\infty$ でも規約が要らない（`G2_cond32_sum_form_top`）。
  有限のときに差の形と同値であることも型に出した（`G2_cond32_sum_form_finite`）。
- **§6.1 はまさに $m^\sharp_0=\infty$ の場合である**（§1.3）。すなわち、
  訂正が塞いだ食い違いのすぐ隣にこの曖昧さがある。

---

## 3. 新たに通した定理群（どれを・なぜ選んだか）

**選んだ基準**: 訂正した D 系列と**直接つながっていて**、かつ **9 サイクル通して一度も Lean に載っていない**もの。
その条件で残っていたのが、定理 G4 の適用範囲の**両端**にあたる次の 2 つである。

### 3.1 系 G6（$S_\infty=\emptyset$）— 退化端

- **なぜ**: これまで型に出ていたのは $d=-2$ だけ（cycle 23 の `D1_d_empty`）で、
  $(a,b,c,e)$ は未検算だった。しかも **§2.1 の新しい発見（$b=0$）の出どころ**がここである。
- `corollary_G6`: 定理 G1 に $\alpha=\gamma=0$, $\beta=A_\mathrm{gen}$ を入れると
  $a=\mu$, $b=0$, $c=\frac{\ell}{\ell-1}A_\mathrm{gen}$, $d=-2$、
  $e=v_\ell(\kappa(X))-\mu+\sum_{M<M^*}\Theta_M-A_\mathrm{gen}\bigl(\mathcal{S}_0(M^*\!-\!1)+\frac{\ell}{\ell-1}\bigr)$。
  **report §5.5 の式と一致する。食い違いは無い。**
- `corollary_G6_c_as_Theta`: $A_\mathrm{gen}=\Theta_L/\ell^{L}$ のとき
  $\frac{\ell}{\ell-1}A_\mathrm{gen}=\frac{\Theta_L}{\varphi(\ell^{L})}$（$L\ge1$）。report の別表示も正しい。

### 3.2 系 Q7（$\ell=2$ トーラスの $b=2$）— $\ell=2$ 端

- **なぜ**: 訂正した定理 D3・D5 の**主役が $\ell=2$ トーラス（$p=1$）**であり、
  系 Q7 はその $b=2$ を定理 G4 とは**別経路**（$\bmod\ 2$ での因数分解）で出す。
  すなわち訂正の対象と直接突き合わせられる。
- `Q7_char2_factorization` / `Q7_char2_binomial_form`: 標数 $2$ の任意の可換体で
  $$w(z-1)^2+z(w-1)^2=w\bigl(zw^{-1}-1\bigr)\bigl(zw-1\bigr)=(z+w)(zw+1).$$
  report §6 が書いている因数分解**そのもの**である。$zw^{-1}=\chi^{(1,-1)}$, $zw=\chi^{(1,1)}$。
- `Q7_b_eq_two`: $r=2$, $m_1=m_2=1$ から $b=2$。定理 G4 の経路（$|S_\infty|=2$, $j^{*}=1$）と同じ値。
- **射程の限定（正直に書く）**: 型に出したのは**因数分解の恒等式だけ**である。
  **$r=2$ そのもの**（2 つの二項式因子が既約かつ非同伴で、これ以上分解しないこと）は形式化していない。
  それには 2 変数 Laurent 環の UFD 性が要る。§5 のとおり mathlib には
  **1 変数 Laurent 多項式はあるが 2 変数（`MvLaurent`）は 3 段検索とも 0 件**である。
  すなわち $b=2$ は「因数分解が実際に 2 つの二項式に分かれること」を**仮定した上での帰結**として
  通しただけであり、$r=2$ の証明ではない。

---

## 4. 検証（実行ログが一次情報）

### 4.1 実行前の負荷

指示どおり **`top` の CPU idle** で判断した（`uptime` の負荷平均は使っていない。cycle 22 step 4 の訂正）。

- 着手時: `CPU usage: 30.54% user, 22.60% sys, **46.85% idle**`
- 最終ビルド直後: `CPU usage: 41.37% user, 19.76% sys, **38.86% idle**`

### 4.2 結果

```
$ lake build
Build completed successfully (8678 jobs).
real 19.68   user 18.79   sys 10.77     （新規モジュールの olean を消してからの計測）
```

```
$ bash scripts/check-no-sorry.sh
OK: ソース中に sorry / admit は無い
...
'IntegrableLattice.Cycle24.Q5_c1_nat_least' depends on axioms: [propext, Quot.sound]
'IntegrableLattice.Cycle24.Q1_C_corrected' depends on axioms: [propext, Classical.choice, Quot.sound]
'IntegrableLattice.Cycle24.corollary_G6' depends on axioms: [propext, Classical.choice, Quot.sound]
'IntegrableLattice.Cycle24.corollary_G6_c_as_Theta' depends on axioms: [propext, Classical.choice, Quot.sound]
'IntegrableLattice.Cycle24.Q7_char2_factorization' depends on axioms: [propext, Classical.choice, Quot.sound]
'IntegrableLattice.Cycle24.Q7_char2_binomial_form' depends on axioms: [propext, Quot.sound]
'IntegrableLattice.Cycle24.Q7_b_eq_two' does not depend on any axioms
OK: 列挙した定理はいずれも sorryAx に依存していない
（終了コード 0）
```

- **定理数 294**（`#print axioms` の出力行数）。cycle 23 は **267** だったので、
  **本 step で 27 増**（`Cycle24Corrections.lean` の全定理）。**cycle 23 の 267 も再確認できている。**
- **jobs 数 8678**。cycle 23 は 8677 で、差は**新規モジュール 1 個**。
- `check-no-sorry.sh` の差分は **対象定理 27 行の追加だけ**である（検査の方式・grep 段は変えていない）。
- ログ: `lean/logs/build-cycle24.log` / `lean/logs/check-no-sorry-cycle24.log` /
  `lean/logs/cache-get-cycle24.log` / `lean/logs/mathlib-gap-survey-cycle24.log`。

### 4.3 `lake-manifest.json` の差分

**差分は無い**（`git diff --stat lake-manifest.json` が空）。すなわち**依存の revision は変わっていない**。
mathlib は `520045ab14e26149ee970e2e617ca04b09bde5d6`（v4.32.1）で cycle 22・23 と同一である。

worktree には `.lake` が無い状態から始めたので `lake exe cache get` で復旧した
（gitignore された依存の復旧。CLAUDE.md「git worktree での作業」）。**一発で取得でき、
cycle 22 のように壊れて取り直す事態は起きていない**ので、`lake update` は実行しておらず、
manifest が書き換わる契機が無い。

### 4.4 壁時計

**1 本のスクリプトの上限 20 分**を守った。最長は `lake exe cache get`
（clone ＋ 展開。ログの最終行が `Completed successfully in 116313 ms`。clone を含む全体でも 1 回の起動内に完了しており、打ち切っていない）。
`lake build` は 19.68 秒、`check-no-sorry.sh` は約 1 分、gap survey は約 1 分。**打ち切りは 0 件。**

---

## 5. 形式化しなかったもの（mathlib の欠落か配線か）

3 段検索（連結語の内容 grep / 語幹の case-insensitive 内容 grep / ファイル名検索）を済ませてから書いている。
**「3 段とも 0 のときにだけ『無い』と書く」**（cycle 21 §9・cycle 22 §9 の誤り記録）。
ログは `lean/logs/mathlib-gap-survey-cycle24.log`（mathlib `520045ab14e2`、走査 8264 ファイル）。

| 概念 | (1) 連結語 | (2) 語幹 | (3) ファイル名 | 判定 |
|---|---|---|---|---|
| 2 変数 Laurent 環（系 Q7 の $r=2$ に要る） | `MvLaurent` **0** | `mv laurent` **0** | **0** | **mathlib に無い**（型が無い） |
| 1 変数 Laurent 多項式（対照） | `LaurentPolynomial` 7 | `laurent` 19 | 3 | 在る（`Mathlib/Algebra/Polynomial/Laurent.lean`） |
| 一意分解環 | `UniqueFactorizationMonoid` 66 | `unique factorization` 26 | 0 | 在る |
| Newton 多面体（再確認） | `NewtonPolytope` **0** | `newton polytope` **0** | **0** | **mathlib に無い** |

したがって **系 Q7 の $r=2$ は「数学的な欠落」ではなく「配線」**である
（多変数 Laurent 環は `MvPolynomial` の局所化として作れ、UFD 性も在る）。
cycle 22 §8.2 の判定と一致し、本サイクルの mathlib でも同じであることを再確認した。

**本 step で使った道具はすべて実在を確認済み**（ビルドが通ることが一次情報）:
`Real.logb`（12 ファイル）・`Real.rpow_logb`（3 ファイル）・`Nat.find`（94 ファイル）・
`ENat`（144 ファイル）・`Nat.totient`（17 ファイル）。
**「在ると思って書いて落ちた」は本 step では起きていない**（§6 の誤り 1 は別種）。

---

## 6. 自分が犯した誤り（記録）

1. **`field_simp` の後に不要な `ring` を付けて `No goals to be solved` で落ちた。**（最重）
   `Q5_c1_strict_of_logb` の補助等式で、`field_simp` が単独でゴールを閉じるのに `ring` を続けた。
   **これは `cycle23_ops_lean_cycle22_theorems.md` §7 の誤り 2 とまったく同じものである。**
   前サイクルの誤り記録を着手前に読んでおきながら再発させた。
   **教訓: 記録を読むだけでは効かない。定型（`field_simp; ring`）を貼る手が先に動く。
   タクティクを 2 つ並べるときは、1 つ目で閉じないことを確かめてから 2 つ目を書く。**
   （cycle 23 総括の「記録は読まれなければ効かない」の一段先の問題である＝読んでも効かなかった。）
2. **`linear_combination` の係数を検算せずに書いた。**
   `Q7_char2_binomial_form` で係数を $zw^2+zw+z-zw$ と当てずっぽうに書き、
   `ring failed` の残差 $-4wz-2w^2z-2z=0$ を見てから手計算し直した。
   正しくは両辺の差が $-4zw$ なので係数は $-2zw$ である。
   **`linear_combination e * h` は「両辺の差 $=e\cdot(\text{左辺}-\text{右辺})$」という等式なので、
   差を先に計算してから書くべきだった。**
3. **`Nat.find` を使う定義を、成立しない場合（$\ell\le1$）ごと 1 つの `def` に押し込もうとした。**
   `c1Nat` を全ての $\ell$ で定義しようとして、存在性の証明の中で $\ell\le1$ を潰せず
   `omega` が落ちた。**定義の全域性のために主張の成り立たない場合を抱え込むのは筋が悪い**ので、
   `def` をやめて「$\ell\ge2$ なら最小の $c_1$ が存在する」という**定理**（`Q5_c1_nat_least`）に組み替えた。
   結果として §2.1 の主張も明確になった。

なお **bash のクォート**で 1 度つまずいた（`check-no-sorry.sh` の対象一覧に
プライム付きの定理名 `Q7_char2_factorization'` を書き、シングルクォートが閉じずスクリプトが
`予期せずファイルが終了しました (EOF)` で落ちた）。定理名を `Q7_char2_binomial_form` へ改名して解決した。
**検査スクリプトが落ちたのを「検査に通った」と取り違えていない**（終了コードと出力の両方を見ている）。

---

## 7. 根拠 report への申し送り（次サイクルの step 1 へ）

**本 step は本文も既存 report も触っていない。**

| # | 箇所 | 内容 | 重さ |
|---|---|---|---|
| 1 | `cycle21_T3_drop_assumption_B_star.md` §5.2 補題 Q5 | $c_1$ が **$b=0$ で定義されない**（$\log_\ell 0$）。$b=0$ は系 G6（$S_\infty=\emptyset$）で実在する。**$c_1$ を「$2b<(\ell-1)\ell^{c}$ なる最小の自然数」と定義し直せば、実対数（ℝ 脱出）も $b=0$ の縮退も同時に消える**（§2.1） | 実質的 |
| 2 | `cycle21_T3_general_closed_form.md` §3.2 定理 G2 $(3.2)$ | $m^\sharp_k=\infty$ のときの $\theta^\sharp_k-m^\sharp_k$ の読み方が無い。**訂正した D3/D5 と同じ型の穴**。証明が使う和の形 $\frac{\varphi(\ell^M)}{\varphi(\ell^k)}+m^\sharp_k>\theta^\sharp_k$ で書けば規約が要らない（§2.2） | 軽微（両方の読みが一致する） |
| 3 | `cycle22_T3_coefficients_d_e.md` §3 注 3.1 | 訂正が自ら「未検証」と書いた帰結（$T_\mathrm{def}=0$ の 108 本で $(1.1)$ が $n=0$ から成り立つか）は**本 step でも検証していない**。sagemath 側の作業 | 未検証項目 |
| 4 | `cycle21_T3_general_closed_form.md` §6.3 | cycle 22 step 4 §5 が挙げた「$n=1$ から完全に一致する」は、step 1 の指示 8 件に入っておらず**今も未訂正**（step 1 report §2 が自分でそう書いている） | 未訂正 |

---

## 8. 新規性

**主張しない。** 本 step は訂正の検算と既存主張の形式化である。
数学的に新しいのは §2.1 の観察（補題 Q5 の $c_1$ から実対数を除去でき、
同時に $b=0$ の縮退も消えること）だけで、これも定義の書き換えであって新しい定理ではない。

---

## 9. 検証コード

`lean/IntegrableLattice/Cycle24Corrections.lean`（27 定理）。
実行ログは `lean/logs/build-cycle24.log` / `lean/logs/check-no-sorry-cycle24.log` /
`lean/logs/cache-get-cycle24.log` / `lean/logs/mathlib-gap-survey-cycle24.log`。
検索スクリプトは `lean/scripts/mathlib-gap-survey-cycle24.sh`。
