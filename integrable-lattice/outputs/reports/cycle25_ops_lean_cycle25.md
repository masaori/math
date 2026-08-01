# cycle 25 / 運用: 訂正後の Q 系と本文の命題 M・U を Lean で検算する

対象: `docs/tasks/auto-loop-state.md` の cycle 25 step 3（`lean_cycle25`）。Lean 化の **10 サイクル目**。
（cycle 17: 誤り 1 件／18: 誤り 2 件／19: 過剰仮定 2 件／20: 誤り 1 件＋暗黙の仮定 1 件＋過剰仮定 2 件／
21: 主張の欠陥 2 件＋過剰仮定 2 件／22: 内部矛盾 1 件＋明示性 1 件＋根拠不足 2 件＋暗黙の仮定 1 件／
23: 主張が偽 1 件＋一意に読めない 1 件／24: 定数が未定義 1 件＋規約の欠落 1 件。）

**本 step が触ったもの**: `lean/IntegrableLattice/Cycle25Corrections.lean`（新規、33 宣言）、
`lean/IntegrableLattice.lean`（import 1 行）、`lean/scripts/check-no-sorry.sh`（**対象定理の追加のみ**）、
`lean/README.md`（対応表・現状表・ログ表への追記）、`lean/logs/`、本 report。
指示どおり **本文（`structured-latex/content/` と `structured-latex/locales/en/content/`）・
`structured-latex/tools/`・既存の根拠 report・`MEMORY.md`・`docs/tasks/auto-loop-state.md` は一切触っていない**（§6）。
push 先は現在の worktree ブランチだけで、**`main` へは push していない**（呼び出し元が検証してから統合する）。

前提として読んだ一次情報: `CLAUDE.md`、`integrable-lattice/README.md`、`docs/tasks/auto-loop-runbook.md`、
`docs/tasks/auto-loop-state.md`（cycle 25 step 列・cycle 24 総括）、`lean/README.md`、
**cycle 24 の 5 本の report の「自分の誤り」節**（とくに `cycle24_ops_lean_cycle23_corrections.md` は全読）、
**cycle 25 step 1 の訂正 report 全文**（`cycle25_ops_fix_q5_c1_and_g2_cond32.md`）、
訂正後の `cycle21_T3_drop_assumption_B_star.md` §5.2・§6 と
`cycle21_T3_general_closed_form.md` §3.2・§5.3・§6.1、
**本文 `structured-latex/content/010_general_closed_form.ts` の全文**（命題 M・命題 U）、
既存の `lean/IntegrableLattice/DropAssumptionBStar.lean` / `GeneralTowerClosedForm.lean` /
`Cycle24Corrections.lean`。

---

## 0. 結論（先に置く）

| 何を | 結果 | 節 |
|---|---|---|
| **cycle 25 step 1 の訂正は塞いだか** | **塞がった。** 新しい $c_1$ の存在・一意性・$b=0$・新旧の大小・中間段・$b=0$ での定理 Q1 の退化形を、**訂正後の形のまま**すべて型に出せた | §1 |
| **$(3.2)$ の規約の必要性** | **形式的に確認した。** $\min\emptyset=0$ の読みでは条件が $\ell\ge4$ に化け、**$\ell=3$ だけが落ちる**（$\ell=5,7$ は落ちない）。正しい読みでは $\ell=3$ でも成り立つ | §2 |
| **本文（命題 M・U）と根拠 report の食い違い** | **検出されなかった。** 本文にしか無い言い回し 6 箇所を型で照合し、すべて根拠から従った。何を見て「無い」と言えるのかは §3.0 | §3 |
| **step の前提そのものの誤り（一次情報で裏取りした結果）** | **1 件。** step の指示は「既存の `lemma_Q5_rho_max` は旧定義向けの仮定になっているはず」と書くが、**そうではなかった**。同定理は狭義不等式そのものを仮定に取っており、$c_1$ の定義の仕方に依存していない | §1.3 |
| **軽微な申し送り** | **1 件。** 本文 (U6) の条件 $N>\max\Lambda_k$ の $\Lambda_k$ は一般に**非整数**（本文 (M2) 自身が $\Lambda_k=j^{*}/\varphi(\ell^{k})$ と書いている）。主張は正しいが、命題 U 冒頭が「$\varphi(\ell^{k})\Lambda_k$ は非負整数」としか書いていないので $\Lambda_k$ 自身を整数と誤読しうる | §4 |
| **新たに通した定理** | $A_\mathrm{gen}$ の**レベル非依存性**（`lean/README.md` が「射影直線のレベル構造。配線」として未形式化に挙げていたもの）と、本文 (M2) の括弧書き「$\lambda$ の値は $\lceil\log_\ell(e_{j^*}+1)\rceil$ に等しい」 | §5 |
| **検証** | `lake build` **8679 jobs**（cycle 24 の 8678 ＋ 新規 1 モジュール）、`check-no-sorry.sh` **327 定理**すべて sorryAx 非依存（cycle 24 の 294 ＋ 本 step の 33） | §6 |
| **自分が犯した誤り** | **3 件。うち 1 件は cycle 24 が「記録を読んだうえで再発させた」と書いた誤りの、さらなる再発である** | §7 |

**新規性は主張しない。** 本 step は既存の主張の検算である。

---

## 1. 訂正後の補題 Q5 の $c_1$（最優先の対象）

方法は前サイクルと同じ「**訂正後の主張をそのまま形式化して通す。通らなければ訂正が不十分**」。
形式化は `lean/IntegrableLattice/Cycle25Corrections.lean`。

### 1.1 新定義が $\mathbb{N}$ 上で定まること

訂正後の定義は $c_1:=\min\{c\in\mathbb{Z}_{\ge0}:2b<(\ell-1)\ell^{c}\}$。

| 訂正後の主張 | Lean | 結果 |
|---|---|---|
| 候補集合は空でない（存在） | `Q5_c1_isLeast`（`Nat.find` 経由で `IsLeast` を作る） | 通った |
| 最小元は一意（＝「$c_1$」が well-defined） | `Q5_c1_unique`（`IsLeast.unique`） | 通った |
| $b=0$ なら $c_1=0$ | `Q5_c1_zero_of_b_zero` | 通った |
| 訂正 report §3.1 の表（$(\ell,b)\mapsto c_1$ の 8 組） | `Q5_c1_table_check`（`decide` による独立再計算） | **8 組すべて一致した** |

**$\mathbb{R}$ を使っていないことの確認**: 上の 4 つの主張と証明に `Real` は 1 つも現れない
（`IsLeast` の台は `Set ℕ`、判定は `Nat` の比較ひとつ）。
**すなわち訂正の目的（実対数＝$\mathbb{R}$ 脱出の除去）は型の上で達成されている。**

### 1.2 $b=0$ で「旧定義はジャンク値で動くが新定義では起こりえない」こと

cycle 24 の `Q5_logb_junk_at_b_zero` は「mathlib の `Real.log 0 = 0` のせいで式が黙って動く」ことまでを
型に出していた。本 step は**その動いた先の値が何であり、なぜ新定義では起こりえないのか**を型に出した。

| 主張 | Lean | 結果 |
|---|---|---|
| 旧定義は $b=0$ で **$1$ を返す**（$\max(0,\lceil1+0\rceil)=1$） | `Q5_old_logb_value_at_b_zero` | 通った |
| その $1$ は候補集合の元ではあるが**最小元ではない**（$0$ が条件を満たす） | `Q5_old_junk_not_least` | 通った |

**これが「新定義では起こりえない」の内容である。** 新定義は狭義不等式に加えて**最小性**を課すので、
$b=0$ で $1$ という値を返しえない。**ジャンク値を排除しているのは狭義不等式ではなく最小性である**——
狭義不等式だけなら $1$ も条件を満たしてしまう（$0<(\ell-1)\ell$）。
**射程の限定**: 型に出したのは「旧定義の値 $1$ が最小でないこと」であって、
「旧定義に数学的根拠が無いこと」そのものではない（後者は形式化できる種類の主張ではない）。

### 1.3 訂正後の証明の場合分けと中間段

| 訂正後の主張 | Lean | 結果 |
|---|---|---|
| $b=0\iff r=0$（$(1.2)$ の $m_i\ge1$ から） | `Q5_b_zero_iff_r_zero` | 通った |
| $b=0$ なら $\mathcal{B}_M=\emptyset$（1 点ぶんの形） | `Q5_BM_empty_of_b_zero` | 通った |
| 中間段 $\rho_{\max}\ge M-c_1$（新定義版） | `Q5_rho_max_of_isLeast` | 通った |
| $\beta_P=+\infty$（ある $i$ で $\rho_i(P)=M$）の枝 | `Q5_rho_max_at_top_layer` | 通った |
| 3 つの枝をまとめた場合分け | `Q5_case_split` | 通った |

**step の前提そのものの誤りを 1 件見つけた（一次情報で裏取りした結果）。**
step の指示は「既存の `lemma_Q5_rho_max` は**旧定義向けの仮定になっているはず**なので新定義版を作ること」と
書いている。**実際には、そうなっていなかった。**
`DropAssumptionBStar.lean:233` の `lemma_Q5_rho_max` の仮定は
`hc₁ : 2 * b < (ℓ - 1) * ℓ ^ c₁`、すなわち**狭義不等式そのもの**であり、
$c_1$ をどう定義したか（対数の切り上げか、$\mathbb{N}$ の最小元か）には依存していない。
したがって新定義版 `Q5_rho_max_of_isLeast` は、`IsLeast` から狭義不等式を取り出して
既存の補題に渡すだけで出る（本体 1 行）。
**新しくなったのは仮定の形ではなく、その狭義不等式を「対数を経由せずに」得る経路のほうである。**
指示の「既存の定理を消さず」は守っている（`lemma_Q5_rho_max` はそのまま残っている）。

**$\beta_P=+\infty$ の枝について、射程を正直に限定する。** `Q5_rho_max_at_top_layer` は
$M-c_1\le M$ という**帳簿上の不等式にすぎない**（cycle 24 が `Q7_b_eq_two` について
「$1+1=2$ という帳簿上の恒等式」と書いたのと同じ種類のものである）。
それでも置いたのは、初稿の証明が $\beta_P\le b\ell^{\rho_{\max}}$ を**無条件に**使っており、
この枝でその不等式が成り立たないことが訂正の中身だからである。
**型に出したのは「この枝では結論が自明であること」だけで、
「$\beta_P=\infty$ となる点が実在すること」（訂正 report §9 の誤り 4 が根拠にした
`_defs21.sage` の `beta_of_point` の枝）は形式化していない。**

### 1.4 新旧の関係と、$C$ が悪化しないこと

| 訂正後の主張 | Lean | 結果 |
|---|---|---|
| $b\ge1$ で $c_1^{新}\le c_1^{旧}$ | `Q5_c1_new_le_old` | 通った |
| $C$ は $r\ell^{c_1}$ について単調増加（＝$C$ は悪化しない） | `Q1_C_mono_in_c1` | 通った |

`Q5_c1_new_le_old` は cycle 24 の `Q5_c1_strict_of_logb`（**ℝ を使う唯一の箇所**）を経由して
「$c_1^{旧}$ が候補集合の元である」を出し、最小性で結論する。
**訂正 report §3.1 が数値に頼らず与えた証明と同じ構造である。**
**ℝ 脱出の所在**: 本ファイルで `Real` が現れるのは
`Q5_old_logb_value_at_b_zero`・`Q5_c1_new_le_old`・`M2_lambda_eq_ceil_logb` の 3 つだけで、
いずれも**旧定義や実対数との対応を述べるため**に使っている。
**訂正後の主張そのものはどれも ℝ を使っていない。**

### 1.5 $b=0$ での定理 Q1 の退化形

| 訂正後の主張（§6 の追記） | Lean | 結果 |
|---|---|---|
| $b=0,r=0$ で $(6.1)$ が $C=\theta_G^{\max}\frac{\ell+1}{\ell}$ に退化する | `Q1_C_at_b_zero`（cycle 24 の `Q1_C_corrected` に代入） | 通った |
| その値が自明な数え上げ $\theta_G^{\max}\cdot\lvert\mathbb{P}^1(\mathbb{Z}/\ell^{M})\rvert$ と一致する | `Q1_b_zero_matches_layer_count` | 通った |

2 つ目は**既存の `DropBStar.layer_card_sum`**（層分解の個数の合計が $(\ell+1)\ell^{M-1}$ であること）を
そのまま使っている。すなわち「$b=0$ の定理 Q1 は自明な数え上げに一致する」という訂正の記述は、
**cycle 22 が別の目的で通した層分解の定理から実際に出る。**
**射程の限定**: 型に出したのは $\theta_G^{\max}\frac{\ell+1}{\ell}\ell^{M}=\theta_G^{\max}(\ell+1)\ell^{M-1}$ と
$(\ell+1)\ell^{M-1}$ が層分解の合計に等しいことであって、
「$\Theta_M=\sum_P\theta_G(P)$」という等式（$b=0$ で $\beta_P\equiv0$ になること）は仮定として置いている。

---

## 2. 定理 G2 $(3.2)$ の規約（$\min\emptyset=0$ の読みで §6.1 の $\ell=3$ が落ちること）

訂正 report §6.2 が計算で示したことを、型に出して確認した。
§6.1 の塔は $k=0$、$\Phi_u=-\ell x^{2}$、$\theta^\sharp_0=2$、$m^\sharp_0=\infty$ で $M^{*}=1$ を使う。

| 主張 | Lean | 結果 |
|---|---|---|
| $\min\emptyset=0$ の読みでは $(3.2)$ が $\varphi(\ell)>2$、すなわち $\ell\ge4$ に化ける | `G2_minEmpty_iff_ell_ge_four` | 通った |
| **その読みでは $\ell=3$ が落ちる** | `G2_minEmpty_breaks_at_ell_three` | 通った |
| **$\ell=5,7$ では落ちない** | `G2_minEmpty_ok_at_ell_five_seven` | 通った |
| 正しい読み（差を $-\infty$）では $\ell=3$ でも成り立つ | `G2_top_reading_ok_at_ell_three` | 通った |

**3 つ目を明示的に置いたことに意味がある。** §6.1 は $\ell=3,5,7$ の 3 つで機械照合しているので、
誤った読みは**照合している 3 つのうち 1 つだけを選択的に壊す**。
全部落ちるなら誤読はすぐ見つかる。**1 つだけ落ちるから、9 サイクル分の検算を通り抜けた。**
これが「規約の明記が必要である」ことの形式的な証拠である。

**射程の限定**: 型に出したのは $(k,M)=(0,1)$、$\theta^\sharp_0=2$ という §6.1 の**具体的な数値での**
条件の成否だけである。「$\ell=3$ で条件 4 が破れると $M^{*}$ が決まらなくなり $e=-2$ の計算が崩れる」
という訂正 report §6.2 の後半（$(2.3)$ の角括弧が $0$ でなくなること）は形式化していない。

---

## 3. 本文（命題 M・命題 U）と根拠 report の照合

### 3.0 「食い違いは無かった」と言える根拠（何を見たか）

**食い違いは検出されなかった。** ただしこれは「見なかったから無い」ではないので、何を見たかを書く。

1. 本文 `010_general_closed_form.ts` の**全 1174 行を読んだ**（命題 M の (M1)–(M6)、命題 U の (U1)–(U6)、
   両方の「限界」節）。
2. 本文の各主張について、対応する根拠 report の節（`cycle21_T3_general_closed_form.md` §3.2・§4・§5.2・
   §5.3・§5.5・§6.1、`cycle22_T3_coefficients_d_e.md` §3）を突き合わせた。
   - (M3) の $\alpha,\beta,\gamma$ は report $(5.2)$$(5.3)$ と**文字どおり一致**。
   - (M5) の条件 1–5 は report §5.3 の条件 1–5 と**文字どおり一致**（訂正後の条件 2・条件 4 を含む）。
   - (M1) の規約と (M2) の $\lambda$ は、cycle 25 step 1 が report 側を本文に合わせて直した後の形と一致。
3. **本文にしか無い言い回し 6 箇所**（report が明示的には述べていない、または本文が独自に付け足した
   導出・数値・括弧書き）を選び、**それが本当に従うのかを型で確かめた**（§3.1–§3.3）。
4. その 6 箇所は**すべて通った**。

**それでも「本文全体に食い違いが無い」とは主張しない。** 型で見たのは下の 6 箇所であり、
とくに **(U4) の $e$ の値（$-1$ と $-4$）は検算していない**（$T_\mathrm{def}$ と $v_\ell(\kappa(X))$ が要り、
それには塔から $\kappa_n$ を計算する段＝Matrix–Tree が要る。§5.2）。

### 3.1 (U1) の係数の式が (M3)+(M4) から出るか

本文は (M3) で $\alpha,\beta,\gamma$ を、(M4) で $c=\frac{\ell}{\ell-1}\beta-\frac{\ell}{(\ell-1)^2}\alpha$,
$d=\gamma-2$ を与え、そのあと (U1) で **$\mathcal{L},\mathcal{T}$ を使った別の形**を与えている。
**この 2 つが整合するかは本文の中で閉じた問題であり、report には書かれていない。**

| 主張 | Lean | 結果 |
|---|---|---|
| (U1) の $c=\frac{\ell}{\ell-1}A_\mathrm{gen}+\sum\bigl[\frac{e_{j^*}\ell^{1-r^\sharp}}{\ell-1}-j^{*}(K+r^\sharp+\frac1{\ell-1})+\mathcal{L}\bigr]$ | `U1_c_from_M3_M4` | 通った |
| (U1) の $d$ | `U1_d_from_M3_M4` | 通った |

**$c$ の側には実際の相殺がある**（$\frac{\ell}{(\ell-1)^2}\alpha$ の項が $-\frac{j^{*}}{\ell-1}$ を生み、
それが $-j^{*}(K+r^\sharp)$ と合わさって $-j^{*}(K+r^\sharp+\frac1{\ell-1})$ になる）。
**$d$ の側は記号の置き換えだけで、数学的な内容は無い**（$\gamma$ を $\mathcal{T}-e_{j^*}\ell^{K}$ と
書き直しただけ）。**帳簿上の恒等式を「形式化した」と書かないため、ここは正直に区別する。**

### 3.2 (M4) の角括弧が (U2) の $T_\mathrm{def}$ と同じものか

本文 (U2) は「(M4) の $e$ の式の角括弧の正体がこの $T_\mathrm{def}$ である」と書いている。
角括弧は $\sum_{M<M^{*}}\Theta_M-\alpha\mathcal{S}_1-\beta\mathcal{S}_0-\gamma(M^{*}-1)$、
$T_\mathrm{def}$ は $\sum_M(\Theta_M-\Theta^\mathrm{as}_M)$ である。

| 主張 | Lean | 結果 |
|---|---|---|
| 2 つが等しい | `U2_bracket_eq_Tdef`（既存の `GeneralTower.S0` / `S1` を使う） | 通った |

**これは本文の 2 箇所（(M4) と (U2)）を結ぶ主張であり、片方だけを読んでいると検証されない。**

### 3.3 (U4) の数値・(M2) の括弧書き

| 本文の主張 | Lean | 結果 |
|---|---|---|
| (U4) の $c=2\mathcal{L}-2$ が (U1) の一般式から出る（$\ell=2$, $\lvert S_\infty\rvert=2$, $A_\mathrm{gen}=2$, $r^\sharp=2$, $K=1$, $j^{*}=1$, $e_{j^*}=2$） | `U4_c_at_ell_two` | 通った |
| (U4) の $d=2\theta^\sharp_1-6$ が (U1) の一般式から出る | `U4_d_at_ell_two` | 通った |
| $p=1$: $\mathcal{L}=v_2(2)+\min(2,v_2(0))=1+2=3$（**規約 $v_2(0)=+\infty$**）、$\theta^\sharp_1=0$ → $(c,d)=(4,-6)$ | `U4_p_one_values` | 通った |
| $p=3$: $\mathcal{L}=v_2(4)+\min(2,v_2(2))=2+1=3$、$\theta^\sharp_1=2$ → $(c,d)=(4,-2)$ | `U4_p_three_values` | 通った |
| 「この対では $\mathcal{L}$ が偶然一致して $c$ が同じになる。$c$ の反例と $d$ の反例は独立に要る」 | `U4_c_same_d_differs` | 通った |
| (M2) の括弧書き「$\lambda$ の値は $\lceil\log_\ell(e_{j^*}+1)\rceil$ に等しい」 | `M2_lambda_eq_ceil_logb` | 通った |

**最後の 1 つが本 step でいちばん実質のある照合である。** cycle 24 step 4 は本文 (M2) の実対数を
「$\ell^{\lambda}\ge e_{j^*}+1$ なる最小の自然数」へ書き換えたが、
**「値は変わっていない」という括弧書きは、それまで誰も確かめていなかった**
（cycle 25 step 1 も report 側を同じ形に直しただけで、値の一致は検算していない）。
$\mathbb{N}$ 上の最小元と $\lceil\log_\ell\rceil$ が一致することを型に出したので、
**書き換えが $\mathbb{R}$ 脱出だけを消して値を保っていることが確定した。**

### 3.4 (U6) の切り捨て付値列

本文 (U6) は「$N>\max\Lambda_k$ なら $\tilde E\bmod\ell^{N}$ が $(\Lambda_k,\theta^\sharp_k)$ を、
したがって $c,d$ を決める」と述べ、その論拠として「切り捨て付値列 $(\min(v_\ell(A_m),N))_m$ が
$\tilde E\bmod\ell^{N}$ で決まる」を挙げている。

| 主張 | Lean | 結果 |
|---|---|---|
| 切り捨て付値列が一致し $\Lambda<N$ なら、$\Lambda$ も $\theta^\sharp$ も一致する | `U6_trunc_determines_stage_data` | 通った |

**射程の限定（2 つある。どちらも重要）**:

1. **形式化したのは「切り捨て付値列 $\Rightarrow$ 段データ」の側だけ**である。
   「$\tilde E\bmod\ell^{N}$ が切り捨て付値列を決める」（$A'^{[k]}_m=A^{[k]}_m+\ell^{N}\beta_m$ の側）は
   $\mathcal{O}_k$ 係数の線形性の配線が要るので形式化していない。
2. **付値が整数値の場合に限る。** 使ったのは cycle 24 の `LamC`/`thC`（$\mathbb{N}\cup\{\infty\}$ 値）なので、
   $\Lambda_k=j^{*}/\varphi(\ell^{k})$ が非整数になる一般の $k$ は含まない（$k=0$ の場合である）。

---

## 4. 申し送り（次サイクルの step 1 へ。本 step は本文も既存 report も直していない）

| # | 箇所 | 内容 | 重さ |
|---|---|---|---|
| 1 | 本文 `010_general_closed_form.ts` (U6) | 条件 $N>\max_{P_0}\max_{k\le K}\Lambda_k$ の $\Lambda_k$ は**一般に非整数**である（本文 (M2) 自身が $\Lambda_k=j^{*}/\varphi(\ell^{k})$ と書いている）。**主張は正しい**（切り捨ては整数 $N$ で行い、$\Lambda_k<N$ が要るだけ）が、命題 U の冒頭が「$\varphi(\ell^{k})\Lambda_k$ は非負整数」としか書いていないので、読者が $\Lambda_k$ 自身を整数と誤読しうる。1 文足すだけで塞がる | 軽微（誤りではない） |
| 2 | step の指示（`auto-loop-state.md` の cycle 25 step 3 相当） | 「既存の `lemma_Q5_rho_max` は旧定義向けの仮定になっているはず」は**事実と違う**（§1.3）。同定理は狭義不等式そのものを仮定に取っており定義非依存だった。**次サイクルの step を起こすときは、既存 Lean の仮定を読んでから前提を書くこと** | 前提の誤り |
| 3 | 本文 (U4) の $e$（$-1$ と $-4$） | **本 step でも検算していない。** $T_\mathrm{def}$ と $v_\ell(\kappa(X))$ が要り、それには塔から $\kappa_n$ を出す段（Matrix–Tree）が要る。SageMath 側の作業 | 未検証項目 |
| 4 | `cycle22_T3_coefficients_d_e.md` §3 注 3.1 | $T_\mathrm{def}=0$ の 108 本で $(1.1)$ が $n=0$ から成り立つか。**cycle 24 step 5 が挙げ、cycle 25 step 1 も塞げなかったと書いている**。本 step も検証していない | 未検証項目（3 サイクル連続で持ち越し） |
| 5 | `cycle21_T3_general_closed_form.md` §6.3 | 「$n=1$ から完全に一致する」が定理の保証範囲外である件。**cycle 24 step 5 が挙げ、cycle 25 step 1 が「手を付けていない、次サイクルへ持ち越す」と明記している**。本 step の担当範囲外 | 未訂正（3 サイクル連続で持ち越し） |

---

## 5. 新たに通した定理と、通さなかったもの

### 5.1 新たに通したもの（どれを・なぜ選んだか）

**選んだ基準**: `lean/README.md` の現状表で「**配線**」と判定されている（＝mathlib の欠落ではなく、
組み立てをしていないだけ）もののうち、**本文へ既に入っている主張**を支えているもの。

- **$A_\mathrm{gen}$ のレベル非依存性**（`sum_of_uniform_fibers` / `Agen_level_indep`）。
  本文 (M3) は $A_\mathrm{gen}$ の定義の直後に「$L$ の取り方に依らない。$L\to L+1$ でファイバーが
  一様に $\ell$ 個に分かれるから」と**理由まで書いて**いる。README は G1–G4 の欄で
  これを「射影直線のレベル構造。**配線**」として未形式化に挙げていた。
  配線の中身は「一様ファイバーの和」なので、`Finset.sum_fiberwise_of_maps_to` で組んだ。
  **射程の限定（正直に書く）**: 「ファイバーが一様に $\ell$ 個であること」と
  「$\theta$ がファイバー上で一定であること」は**仮定として置いている**。
  前者は射影直線のレベル構造、後者は $U$ の外を除いた上での $\theta$ の性質であり、
  どちらも本 step では証明していない。**型に出したのは、その 2 つから $L$ 非依存性が出るという含意だけ**である。
- **本文 (M2) の括弧書き**（`M2_lambda_eq_ceil_logb`）。理由は §3.3 に書いた。

### 5.2 通さなかったもの（何が足りないか）

| 概念 | 判定 | 根拠 |
|---|---|---|
| 2 変数 Laurent 環（系 Q7 の $r=2$） | **mathlib に無い**（型が無い） | cycle 22 §8.2 と cycle 24 §5 が **3 段検索**（連結語の内容 grep / 語幹の case-insensitive 内容 grep / ファイル名検索）で確認済み。`logs/mathlib-gap-survey-cycle22.log` / `..._cycle24.log`。**本 step は繰り返していない**（mathlib の revision は `520045ab14e2` で cycle 22・24 と同一。`lake-manifest.json` の差分は無い） |
| Kirchhoff の Matrix–Tree・全域木数 | **mathlib に無い** | 同上（cycle 21・22・24 が確認） |
| Newton 多面体（系 W7） | **mathlib に無い** | 同上 |
| 定理 G2 の 1（Galois 不変性）と 3（$\varphi(\ell^{k})\Lambda_k\in\mathbb{Z}_{\ge1}$） | **配線**（mathlib には在る） | 円分体の分岐は `ramificationIdx` / `inertiaDeg`、円分拡大は `IsCyclotomicExtension` として実在することを cycle 21・22 が確認済み。**組み立てをしていないだけ**であり、本 step の時間は §1–§3 の照合に使った |
| (U6) の「$\tilde E\bmod\ell^{N}$ が切り捨て付値列を決める」側 | **配線** | $\mathcal{O}_k$ 係数の線形性。同上 |

**本 step で使った道具はすべて実在を確認済み**（ビルドが通ることが一次情報）:
`IsLeast` / `IsLeast.unique` / `Nat.find` / `Finset.sum_fiberwise_of_maps_to` /
`Real.logb_le_iff_le_rpow` / `Int.ceil_le` / `Int.le_ceil` / `Real.logb_nonneg` /
`Nat.totient_prime` / `DropBStar.layer_card_sum` / `Cycle24.LamC` / `Cycle24.thC`。
**「在ると思って書いて落ちた」は本 step では起きていない**（§7 の誤りは別種）。

---

## 6. 検証（実行ログが一次情報）

### 6.1 実行前後の負荷

指示どおり **`top` の CPU idle** で判断した（`uptime` の負荷平均は使っていない）。

- 着手時（`lake exe cache get` 開始直前）: `CPU usage: 57.54% user, 26.71% sys, **15.73% idle**`
- 最終確認時: `CPU usage: 33.24% user, 22.84% sys, **43.91% idle**`

### 6.2 結果

```
$ lake build
Build completed successfully (8679 jobs).
EXIT=0
```

```
$ bash scripts/check-no-sorry.sh
OK: ソース中に sorry / admit は無い
...
'IntegrableLattice.Cycle25.Q5_c1_table_check' depends on axioms: [propext, Classical.choice, Quot.sound]
'IntegrableLattice.Cycle25.Q5_old_junk_not_least' depends on axioms: [propext, Quot.sound]
'IntegrableLattice.Cycle25.Q5_rho_max_at_top_layer' does not depend on any axioms
'IntegrableLattice.Cycle25.M2_lambda_eq_ceil_logb' depends on axioms: [propext, Classical.choice, Quot.sound]
'IntegrableLattice.Cycle25.U6_trunc_determines_stage_data' depends on axioms: [propext, Classical.choice, Quot.sound]
'IntegrableLattice.Cycle25.sum_of_uniform_fibers' depends on axioms: [propext, Classical.choice, Quot.sound]
'IntegrableLattice.Cycle25.Agen_level_indep' depends on axioms: [propext, Classical.choice, Quot.sound]
OK: 列挙した定理はいずれも sorryAx に依存していない
EXIT=0
```

- **定理数 327**（`#print axioms` の出力行数）。cycle 24 は **294** だったので、
  **本 step で 33 増**（`Cycle25Corrections.lean` の全宣言）。**cycle 24 の 294 も再確認できている。**
- **jobs 数 8679**。cycle 24 は 8678 で、差は**新規モジュール 1 個**。
- ログ: `lean/logs/build-cycle25.log` / `lean/logs/check-no-sorry-cycle25.log` /
  `lean/logs/cache-get-cycle25.log`。

### 6.3 `check-no-sorry.sh` の差分は追加だけで、検査を緩めていないこと

```
$ git diff --numstat lean/scripts/check-no-sorry.sh
37	0	integrable-lattice/lean/scripts/check-no-sorry.sh
$ git diff lean/scripts/check-no-sorry.sh | grep '^-' | grep -v '^---'
（出力なし）
```

**削除行 0・変更行 0・追加 37 行**（対象定理 33 行＋見出しコメント 4 行）。
grep 段・`lake env lean --stdin` 段・終了コードの扱いは 1 文字も変えていない。
**既存ターゲットの削除も条件の緩和もしていない。**

### 6.4 `lake-manifest.json` の差分

**差分は無い**（`git status` に現れない）。すなわち依存の revision は変わっていない。
mathlib は `520045ab14e26149ee970e2e617ca04b09bde5d6`（v4.32.1）で cycle 22・24 と同一である。
worktree には `.lake` が無い状態から始めたので `lake exe cache get` で復旧した
（gitignore された依存の復旧。CLAUDE.md「git worktree での作業」）。
`lake update` は実行しておらず、manifest が書き換わる契機が無い。

### 6.5 壁時計（1 本のスクリプトの上限 20 分を守った）

| 実行 | 壁時計 | 打ち切り |
|---|---|---|
| `lake exe cache get`（clone 含む） | ログ末尾 `Completed successfully in 73598 ms!`。clone を含めても 1 回の起動内に完了 | 無し |
| `lake build`（3 回。1 回目は失敗） | 最長でも数分（mathlib は cache 済み。新規モジュールは 7〜17 秒） | 無し |
| `bash scripts/check-no-sorry.sh`（2 回） | 各 1 分程度 | 無し |

**打ち切りは 0 件。**

### 6.6 担当範囲外に差分が無いこと

```
$ git diff --stat origin/main...HEAD
```
（§8 に実際の出力を貼る。`lean/` 配下と `outputs/reports/cycle25_ops_lean_cycle25.md` のみ。）

---

## 7. 自分が犯した誤り（隠さず記録する）

1. **`field_simp` の後に不要な `ring` を付けて `No goals to be solved` で落ちた。2 箇所。**（最重）
   `Q1_b_zero_matches_layer_count` と `Agen_level_indep` の両方でやった。
   **これは `cycle23_ops_lean_cycle22_theorems.md` §7 の誤り 2 であり、
   `cycle24_ops_lean_cycle23_corrections.md` §6 の誤り 1 でもある。**
   cycle 24 は「記録を読むだけでは効かない。定型（`field_simp; ring`）を貼る手が先に動く。
   タクティクを 2 つ並べるときは、1 つ目で閉じないことを確かめてから 2 つ目を書く」と教訓まで書いており、
   **私はその文を着手前に全読したうえで、同じ誤りを 2 箇所でやった。3 サイクル連続の再発である。**
   **なぜ効かなかったか（自分の手順に落とす）**: 「読んだら守れる」という前提が間違っている。
   `field_simp` を書いた瞬間に `ring` まで一続きの語として出力されるので、
   読んだ記憶は出力の途中に介在しない。**機械で落ちる形にするしかない。**
   最小の実装は「`field_simp` を書いたら、その行で一度ビルドして残ゴールを見る」という
   手順ではなく、**`field_simp` の直後に `ring` を書かない**という構文レベルの禁止である
   （必要なら落ちてから足す。落ちるコストは 10 秒のビルドで、逆向きのコスト＝
   不要な `ring` で落ちるコストと同じである）。本 step の是正もその形で行った
   （`ring` を消す方向で直し、消して通ることを確認した）。
   **次サイクルへの申し送りとして、この 1 行を守れるかどうかがそのまま試金石になる。**
2. **`norm_num` が閉じきると決めつけて `ring` を書かなかった箇所で、逆に落ちた。2 箇所。**
   `U4_c_at_ell_two`（$4+2(-3+L_c)=2L_c-2$）と `U4_d_at_ell_two`。
   1 の反省で「タクティクを 2 つ並べない」に寄せた結果、今度は**足りない側**で落ちた。
   **教訓の一般形は「並べるな」ではなく「1 つ目の残ゴールを見てから 2 つ目を決めろ」である。**
   実際、ビルドの出力が残ゴール（`⊢ 4 + 2 * (-3 + Lc) = 2 * Lc - 2`）をそのまま印字しており、
   それを見てから `ring` を足した。**この 2 件と 1 の 2 件は、同じ手順の表と裏である。**
3. **`ENat` の `min` の向きを取り違えて 2 箇所で型が合わなかった。**
   `U6_trunc_determines_stage_data` の補助で `absurd hi.symm (ne_of_lt hvi)` と書いたが、
   `hi` は `v i = N`、`ne_of_lt hvi` は `v i ≠ N` なので `.symm` が余計だった
   （もう 1 箇所は逆に `.symm` が足りなかった）。
   **`absurd` に渡す 2 つの向きを、書く前に紙の上で合わせていなかった。**
   コンパイラのメッセージ（`has type v i < ↑N but is expected to have type ↑N < v i`）が
   向きをそのまま指しており、それを読んで直した。

なお、**バックグラウンド実行のシェルで作業ディレクトリを取り違えて 2 回失敗した**
（`cd lean` を打ったが、既に `lean/` に居たため `No such file or directory` になり、
1 回目は `lake build` が走らずログが空のまま「失敗」と通知された）。
**これは `cycle25_ops_fix_q5_c1_and_g2_cond32.md` §9 の誤り 3（作業ディレクトリの取り違え）と同型**で、
前 step が記録済みの誤りの再発である。以後、ディレクトリを跨ぐ実行は `pwd` を先頭に置いて確認する
（本 report の後半のコマンドはそうしている）。
**「ログが空なのに失敗と出た」を「ビルドが失敗した」と読み違えてはいない**
（出力ファイルを実際に開いて `cd: lean: No such file or directory` を確認した）。

---

## 8. 担当範囲外に差分が無いこと

```
$ git diff --stat origin/main...HEAD
 integrable-lattice/lean/IntegrableLattice.lean     |   1 +
 .../lean/IntegrableLattice/Cycle25Corrections.lean | 595 +++++++++++++++++++++
 integrable-lattice/lean/README.md                  |  10 +
 integrable-lattice/lean/logs/build-cycle25.log     | 179 +++++++
 integrable-lattice/lean/logs/cache-get-cycle25.log |  48 ++
 .../lean/logs/check-no-sorry-cycle25.log           | 336 ++++++++++++
 integrable-lattice/lean/scripts/check-no-sorry.sh  |  37 ++
 .../outputs/reports/cycle25_ops_lean_cycle25.md    | 456 ++++++++++++++++
 8 files changed, 1662 insertions(+)
```

（作業中に `origin/main` が cycle 25 step 2 の成果で前進したので、コミット後に取り込み直して
上を取り直した。取り込みでコンフリクトは無く、step 2 が触ったのは `structured-latex/tools/` 配下で
本 step の担当範囲と重ならない。）
**すべて `integrable-lattice/lean/` 配下と `integrable-lattice/outputs/reports/` の自分の report である。**
本文（`structured-latex/content/`・`structured-latex/locales/en/content/`）、`structured-latex/tools/`、
既存の根拠 report、`MEMORY.md`、`docs/tasks/auto-loop-state.md` に差分は無い。

---

## 9. 新規性

**主張しない。** 本 step は訂正の検算と既存主張の形式化・照合である。
数学的に新しいものは無い。強いて言えば §3.3 の `M2_lambda_eq_ceil_logb`
（$\mathbb{N}$ 上の最小元と実対数の切り上げが一致すること）が、
これまで本文の括弧書きとしてだけ主張されていたものを確定させたが、
これは初等的な事実であって新しい定理ではない。

---

## 10. 検証コード

`lean/IntegrableLattice/Cycle25Corrections.lean`（595 行、33 宣言）。
実行ログは `lean/logs/build-cycle25.log` / `lean/logs/check-no-sorry-cycle25.log` /
`lean/logs/cache-get-cycle25.log`。
mathlib 欠落調査は**本 step では新規に実施していない**（§5.2 の理由）。
