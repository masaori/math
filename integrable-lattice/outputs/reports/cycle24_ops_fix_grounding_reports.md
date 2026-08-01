# cycle 24 / 運用: 未訂正の根拠 report を一括で訂正する

対象: `docs/tasks/auto-loop-state.md` の cycle 24 step 1（`fix_grounding_reports`）。
cycle 22・cycle 23 の Lean 検算と文献 step が根拠 report に検出しながら、
**本文反映が方針変更で中断されたために未訂正のまま残っていた 8 件**を直した。

**本 step が触ったもの**: `outputs/reports/` の 4 本（下表）と本 report だけである。
指示どおり、**本文（`structured-latex/content/`・`structured-latex-en/`）・`lean/`・
`structured-latex/tools/`・`MEMORY.md`・`docs/tasks/auto-loop-state.md` は一切触っていない。**
push 先は現在の worktree ブランチだけで、**`main` へは push していない**（逸脱ログ 2026-07-31 の 2 件を踏まえた）。

前提として読んだ一次情報:
`CLAUDE.md`、`integrable-lattice/README.md`、`docs/tasks/auto-loop-runbook.md`、
`docs/tasks/auto-loop-state.md`（cycle 24 step 列・cycle 23 総括・**逸脱ログ**）、
`cycle23_ops_lean_cycle22_theorems.md`、`cycle22_ops_lean_cycle21_theorems.md`、
`cycle23_T3_cuoco_thesis_acquisition.md`、`cycle20_ops_lean_cycle19_theorems.md` §7 と
`cycle21_ops_lean_cycle20_theorems.md` §9（**過去サイクルの誤り記録**）、
および訂正対象 4 本の当該節（`cycle22_T3_coefficients_d_e.md` §3・§5.1・§6.2、
`cycle21_T3_general_closed_form.md` §4・§5.3、`cycle21_T3_drop_assumption_B_star.md` §5.2・§6、
`cycle22_T3_cuoco_monsky_attribution.md` §4・§10）。

---

## 0. 結論（先に置く）

**8 件すべて訂正した。うち 1 件は主張が偽、1 件は主張が一意に読めない、1 件は内部矛盾、
1 件は「明示定数」が明示定数でない、2 件は根拠不足、1 件は暗黙の仮定、1 件は事実（ページ番号）の誤りである。**

| # | どの report のどこ | 何が誤りだったか | 何に直したか | 検出元（一次情報） |
|---|---|---|---|---|
| 1 | `cycle22_T3_coefficients_d_e.md` §3 定理 D2 の最後の一文 | **主張が偽**。「$T_\mathrm{def}=0\iff$ 閉形式 $(1.1)$ が $n\ge0$ から成り立つ」の $\Rightarrow$ が成り立たない。証明が**総和から部分和へ飛んでいた** | $T_\mathrm{def}=0$ と同値なのは「$(1.1)$ が **$n=0$ で**成り立つこと」。**全 $n\ge0$** と同値なのは $\Theta_M=\Theta^\mathrm{as}_M$ が全 $M\ge1$（過渡が一切無い）で、これは真に強い。証明も残差 $S(n)-T_\mathrm{def}$ の計算へ差し替え、反例と射程の限定を書いた | `cycle23_ops_lean_cycle22_theorems.md` §1（`D2_residual` / `D2_equiv_forward_false` / `D2_equiv_corrected`） |
| 2 | 同 §5.1 定理 D3 の 2、同 §6.2 定理 D5 | **主張が一意に読めない**。$\Lambda_1=\min(\cdot,\cdot)$ の $\min$ を $A_m\ne0$ の $m$ に限る規約が無い | 両定理に「$\min$ は $A_m\ne0$ の $m$ についてのみ取る（$v_2(0)=+\infty$）」を明記。$p=1$（$A_2=0$）で $\Lambda_1=2,\theta^\sharp_1=0$、$t=q$（$A_2=0$）で $\Lambda_1=v_2(4(p+t)),\theta^\sharp_1=0$ を追記 | 同 §2（`D3_p_eq_one_convention`） |
| 3 | `cycle21_T3_general_closed_form.md` §5.3 条件 2 | **内部矛盾**。$M\ge r^\sharp+\max K+1$ は 1 つ強すぎ、**同 report §6.1 が自分でこの条件を破っていた** | $M\ge r^\sharp+\max_{P_0}K(P_0)$（$+1$ を落とす）。括弧内の理由も「層が空でない」→「(b) の閉形式が成り立つ境界」へ | `cycle22_ops_lean_cycle21_theorems.md` §1（`sum_totient_Ico` / `layer_b_boundary`） |
| 4 | `cycle21_T3_drop_assumption_B_star.md` §6 定理 Q1 $(6.1)$ | **「明示定数」が明示定数でない**。$C$ が $|\mathcal{B}_M|$ を含み **$M$ に依存**していた | 補題 Q5 の上界を代入し $C:=b(3+r\ell^{c_1})+\theta_G^{\max}\frac{\ell+1}{\ell}+r\ell^{c_1}\log_\ell C_0$。証明にも置き換えの正当性（定理の仮定の下で補題 Q5 が使えること、$\log_\ell C_0\ge0$）を書いた | 同 §2（`theorem_Q1_error` / `theorem_Q1_error_explicit`） |
| 5 | 同 §5.2 補題 Q5 | **根拠不足**。効いているのが**狭義**不等式 $2b<(\ell-1)\ell^{c_1}$ であること（＝ $c_1$ の $+1$ の役割）が書かれていない | 証明に狭義性の段落を追加。$+1$ が無いと $\frac{2b}{\ell-1}$ が $\ell$ の冪ちょうどのとき等号で破れることと、反例（$\ell=2,b=1,c_1=1,M=3,\rho=1$）を書いた | 同 §3.1（`lemma_Q5_rho_max` / `lemma_Q5_needs_strict`） |
| 6 | `cycle21_T3_general_closed_form.md` §4 注 4.2 | **根拠不足**。主張は正しいが、$K\to K+1$ で $(5.3)$$(5.4)$ の増分が打ち消し合う計算が無く、読み手が検証できない | 注 4.2 に「理由」段落を追加（$(5.4)$ 側は $e_{j^*}(\varphi(\ell^{K+1})-\ell^{K+1}+\ell^{K})=0$、$(5.3)$ 側は $\frac{(\ell-1)j^*}{\ell}$ の相殺） | `cycle22_ops_lean_cycle21_theorems.md` §3.2（`G4_K_dependence`） |
| 7 | `cycle21_T3_drop_assumption_B_star.md` §6 定理 Q1 の証明 | **暗黙の仮定**。補題 Q0 の適用に要る $\tilde E(\omega_P)\ne0$ が $\mathcal{B}_M$ 上で確認されていない | 証明に「(H) $\Rightarrow\kappa_n\ne0\Rightarrow\Sigma_n$ 有限 $\Rightarrow\mathcal{B}_M$ の点でも $\tilde E(\omega_P)\ne0$」を明示 | 同 §4 |
| 8 | `cycle22_T3_cuoco_monsky_attribution.md` §4・§10 | **事実の誤り**。Cuoco–Monsky の当該文の頁が **p.248 ではなく p.252** | 両所を p.252 へ訂正し、「詳細（further information）」の参照先が **[2]（Cuoco 1980）と [5]（Monsky 1981）であって学位論文 [1] ではない**ことを明記。§10 の残件も cycle 23 で決着したことを追記 | `cycle23_T3_cuoco_thesis_acquisition.md` §0・§3.4（p.248 と p.252 の原画像を直読） |

**訂正はすべて「いつ・どの検出に基づくか」を書いた注記つきで入れてある**（`【訂正 2026-08-01（cycle 24 step 1）】`）。
**初稿に何が書かれていたかも消さずに残した**（何が偽だったかが後から辿れるように）。

---

## 1. 訂正前に自分で確かめた数学（Lean report の結論を写していない）

指示のとおり、各件について **report 本文の証明と突き合わせて、何が正しいかを自分で導いてから**書いた。

### 1.1 定理 D2（#1）

$\delta_M:=\Theta_M-\Theta^\mathrm{as}_M$、$S(n):=\sum_{M=1}^n\delta_M$ と置くと、残差は $S(n)-T_\mathrm{def}$。
$T_\mathrm{def}=\sum_{M\ge1}\delta_M$ は有限和（$M\ge M^*$ で $\delta_M=0$）なので $n\ge M^*-1$ では $S(n)=T_\mathrm{def}$、
すなわち閉形式は成り立つ。$n=0$ は $S(0)=0$ なので $T_\mathrm{def}=0$ と同値。
**全 $n\ge0$ で成り立つ $\iff S$ が定数 $\iff \delta_M=0\ (\forall M\ge1)$** であり、
このとき $T_\mathrm{def}=0$ だが逆は言えない。初稿の証明は
「$T_\mathrm{def}=0$ は $\sum_{M<M^*}\delta_M=0$ を意味する」から
「$\Sigma_n$ が全ての $n$ で漸近形と一致する」へ、**部分和の消滅を挟まずに**飛んでいた。

### 1.2 §5.3 条件 2（#3）

$\sum_{r=r^\sharp}^{M-K-1}\varphi(\ell^{M-r})$ を $s=M-r$ で書き換えると $\sum_{s=K+1}^{M-r^\sharp}\varphi(\ell^s)$。
$\sum_{s=1}^{S}\varphi(\ell^s)=\ell^{S}-1$ より、これは $M-r^\sharp\ge K$ のとき $\ell^{M-r^\sharp}-\ell^{K}$ に等しい。
$M-r^\sharp=K$ では**両辺とも $0$**（空和）なので成り立ち、$M-r^\sharp<K$ で初めて破れる（右辺が負になる）。
よって必要なのは $M\ge r^\sharp+K$ で、$+1$ は不要である。
**§6.1 が $r^\sharp=1,K=0$ で $M^*=1$ を使っていることと、この訂正後の条件は整合する。**

### 1.3 定理 Q1 の $C$（#4）

補題 Q5 は定理 Q1 と**同じ仮定**（$\varphi(\ell^M)\ge2\theta_G^{\max}$ かつ $M>c_1$）の下で $|\mathcal{B}_M|\le r\ell^{c_1}$ を与える。
$(6.1)$ の右辺で $|\mathcal{B}_M|$ が現れるのはすべて**非負の係数**（$b\ell^M$、$\ell^M\log_\ell C_0$。
$C_0=\sum|c_{pq}|\ge1$ より $\log_\ell C_0\ge0$）に掛かる形なので、上界で置き換えても不等式は保たれる。
したがって置き換えた $C$ は正しく、かつ $M$ に依らない。

### 1.4 補題 Q5 の狭義性（#5）

$\rho_{\max}$ は整数なので、$\ell^{\rho_{\max}}\ge\ell^{M-1}(\ell-1)/(2b)$ から $\rho_{\max}\ge M-c_1$ を出すには
$\ell^{M-1}(\ell-1)/(2b)>\ell^{M-c_1-1}$、すなわち $(\ell-1)\ell^{c_1}>2b$ が要る（**狭義**）。
$c_1\ge1+\log_\ell\frac{2b}{\ell-1}$ より $(\ell-1)\ell^{c_1}\ge2b\ell>2b$（$\ell\ge2$）なので $+1$ 付きの定義では満たされる。
$+1$ が無いと $\frac{2b}{\ell-1}$ が $\ell$ の冪ちょうどのときに等号になり、Lean report の反例
（$\ell=2,b=1,c_1=1,M=3,\rho=1$: $2b\ell^\rho=4=(\ell-1)\ell^{M-1}$ だが $M-c_1=2>1$）が実際に成立する。

### 1.5 注 4.2 の打ち消し（#6）

$K\to K+1$ で深さ $K+1$ の層は定理 G3 より非飽和、$(4.2)$ より $\Lambda_{K+1}=j^*/\varphi(\ell^{K+1})$、$\theta^\sharp_{K+1}=e_{j^*}$。
$(5.4)$: $+\varphi(\ell^{K+1})e_{j^*}$ と $-e_{j^*}\ell^{K+1}+e_{j^*}\ell^{K}$ の和は
$e_{j^*}((\ell^{K+1}-\ell^{K})-\ell^{K+1}+\ell^{K})=0$。
$(5.3)$: $+\frac{\ell-1}{\ell}\varphi(\ell^{K+1})\cdot\frac{j^*}{\varphi(\ell^{K+1})}=+\frac{(\ell-1)j^*}{\ell}$ と
$-\frac{(\ell-1)j^*}{\ell}$（$K\to K+1$ の分）で $0$。**両方とも自分で計算して確認した。**
同じ計算が `cycle22_T3_coefficients_d_e.md` §2.3（命題 D1a）に $(2.2)$$(2.3)$ の形で独立に書かれていることも確認した
（すなわちこの訂正は既存の別 report と矛盾しない）。

---

## 2. 訂正しなかったもの（範囲外・および直せなかったもの）

**直せなかったものは無い。指示の 8 件はすべて訂正した。** ただし次の 2 件は**指示の 8 件に入っていないので触っていない**。
次の担当（本文反映 step / rank）が扱うかを判断すること。

1. **`cycle21_T3_general_closed_form.md` §6.3 の「$n=1$ から完全に一致する」**
   （`cycle22_ops_lean_cycle21_theorems.md` §5 の指摘。定理 G1 の保証は $n\ge M^*-1$ で、この塔では
   訂正後の条件 2 でも $M^*\ge r^\sharp+K=3$ なので $n=1$ は保証範囲の外。**一致自体は事実**）。
   同 §5 は併せて「§6.3 が $e=-1$ をどう出したかを書いていない」も挙げている。
   **cycle 22 step 4 report の §10 の表では 6 番目の項目にあたるが、本 step の指示 8 件には含まれていない。**
2. `cycle21_T3_drop_assumption_B_star.md` §12 の敵対的レビュー表にある
   「$C$ は $M\ge$ 小さいレベルで一定になる（$|\mathcal{B}_M|$ が一定になるため）」という**実測についての記述**。
   訂正後の $(6.1)$ では $C$ は定義から $M$ 非依存なので、この行は実測の話としては正しいが、
   $(6.1)$ の話としては古い書き方である。**主張の誤りではないので触っていない。**

なお **#1 の訂正から導かれる検証可能な帰結**（$T_\mathrm{def}=0$ の 108 本では $(1.1)$ が $n=0$ で成り立つ）は
**まだ検証されていない**。注 3.1 にその旨を明記した（検証は sagemath 側の作業なので本 step の範囲外）。

---

## 3. 編集の安全策（逸脱ログ 2026-07-26 への対応）

逸脱ログの「文書の一部を差し替えるときは (1) `index()` による splice を使わず**出現回数を検査する置換**にする、
(2) 置換後に**行数と見出し一覧を確認**してからコミットする」に従った。

- 置換はすべて**一意一致を強制する置換**で行った（一致が 1 でなければ失敗して何も書かない）。
  実際に 1 回、一致しない `old_string` で**失敗して中断**している（`see [2,5].` の句読点の食い違い。
  推測で書き換えず、生の行を読み直してから再実行した）。
- 編集後に**行数と見出し一覧を before/after で比較**した。

| ファイル | 行数（前 → 後） | 見出し |
|---|---|---|
| `cycle22_T3_coefficients_d_e.md` | 782 → 832 | **完全一致（増減なし）** |
| `cycle21_T3_general_closed_form.md` | 698 → 727 | **完全一致** |
| `cycle21_T3_drop_assumption_B_star.md` | 651 → 682 | **完全一致** |
| `cycle22_T3_cuoco_monsky_attribution.md` | 312 → 335 | **完全一致** |

- `git diff` の**削除行を 1 行ずつ確認**し、削除がすべて意図した差し替え対象だけであることを確かめた
  （削除 12 行。うち 8 行は訂正対象の本文、4 行は同じ段落の書き直し）。
- **「エラーが出なかった」を根拠にしていない。** 編集した節そのものを読み直して確認している（§4 の 1 件はそれで見つけた）。

---

## 4. 自分が犯した誤り（記録）

1. **置換の `old_string` に行の先頭部分だけを渡し、行の残りが後ろにくっついたまま残った。**（最重）
   定理 D5 の規約を足すとき、対象行を `> *で与えられる。` で切って渡したが、実際の行は
   `> *で与えられる。とくに $t=1$、…を取ると、` と続いていた。置換は成功し、結果として
   **「…である。**とくに $t=1$、…」と 2 文が同一行で連結し、「とくに」が 2 回続く壊れた文になった。
   **逸脱ログ 2026-07-26 の事故（`index()` の最初の一致がヘッダ行だった）と根は同じで、
   「自分が想定した文字列」と「ファイルに実在する文字列」を突き合わせずに編集した**ことによる。
   **検出は、編集後に当該節を読み直したこと**（逸脱ログの再発防止策 (2)）。行を分けて再訂正した。
   **教訓: 置換の対象は行の途中で切らず、少なくとも 1 行を丸ごと（できれば前後の文脈ごと）指定する。**
2. **step の指示文の要約を、一次情報より先に信じかけた。**
   指示 8 番は「頁番号の誤り、かつ『詳細』の参照先は学位論文ではなく [2,5]」とあったので、
   `cycle22_T3_cuoco_monsky_attribution.md` §4 が**引用文そのものを誤って写している**と想定した。
   実際に §4 を読むと引用文は原文どおり（"For further information about them … see [2,5]."）で、
   **誤っていたのは頁番号と、§10 の「CM p.248 が $l_0$ の出所として挙げる 2 件」という読み方の方**だった。
   一次情報（当該 report の当該行と cycle 23 report §3.4）を読んでから訂正範囲を決め直した。
   **cycle 23 総括が「前サイクルの誤り記録を読んでから着手する」と申し送ったのと同じ型の罠である。**
3. **`wc -l` の before を取り直さずに一度 after と比べかけた。**
   D5 の再訂正（誤り 1 の是正）で行数が 831 → 832 に変わったため、§3 の表は再訂正後の値へ取り直した。
   **中間状態の数値を成果物へ書くところだった。**

過去サイクルの誤り記録（cycle 20 §7・cycle 21 §9・cycle 22 §9・cycle 23 §7）で繰り返し出ている
**「確認せずに書いた」**は、本 step では数学の側では出していない（§1 のとおり各件を自分で導いてから書いた）。
一方、**編集操作の側で同型の誤りを 1 件やった**（誤り 1）。**規律は対象を選ばない。**

---

## 5. 新規性

**主張しない。** 本 step は既存 report の訂正であり、新しい数学は無い。
訂正の内容はすべて cycle 22・cycle 23 の Lean 検算と文献 step が既に検出していたもので、
本 step はそれを一次情報と突き合わせて確認し、report へ反映しただけである。
