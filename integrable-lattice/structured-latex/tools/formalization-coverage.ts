/**
 * **検査 F（形式化の被覆）の型と台帳**。
 *
 * ## 目標（2026-08-03 ユーザー方針。解除されるまで有効）
 *
 * > **論文の主張を全数 Lean 形式化することを目標とする。**
 *
 * 一部の形式化で足れりとしない。したがって**未形式化の件数を毎サイクル出す**——
 * 証明の欠落や機械検証できない免除の件数を毎回出しているのと同じ扱いにして、
 * 放置されたら見えるようにする。
 *
 * ## 状態の 3 語（`lean/README.md` の表と同じ語彙）
 *
 * - `完了` — その主張の内容が Lean で証明されている。
 * - `部分的` — 一部だけ。**何が残っているかを `remaining` に書く**（型で必須）。
 * - `未着手` — まだ手を付けていない、または原理的に難しい。
 *   **なぜかを `reason` に書く**（型で必須）。「難しそう」は理由ではない。
 *   mathlib に無いことが理由なら、**何をどう調べて無いと判断したか**を書く
 *   （先例: `lean/README.md` の「mathlib 欠落調査の一次情報」。8264 ファイルを 3 段で引いている）。
 *
 * ## 機械が確かめること
 *
 * 1. **本文の `theorem` / `claim` ブロックが 1 つ残らず台帳にあること。** 黙って落とせない。
 * 2. **台帳の登録が本文に実在すること。** 改名・削除で宣言が浮いたら赤くなる。
 * 3. **`完了` と `部分的` は、そのブロックが Lean の定理名を 1 つ以上持つこと。**
 *    形式化したと言うなら、読者が辿れる先が要る。
 * 4. **`未着手` は Lean の定理名を持たないこと。** 持っているなら少なくとも `部分的` である。
 * 5. **本文が宣言する Lean の定理名が、`lean/` に実在すること。**
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **`完了` が本当に完了かは機械で確かめられない。** 「その主張の内容が形式化されている」は
 *   人の判断である。この検査が保証するのは、判断が**書かれていること**と、
 *   書かれた判断が**腐っていないこと**だけである。
 * - 同じ理由で、`部分的` の `remaining` が実態と合っているかも確かめられない。
 */

export type CoverageState = "完了" | "部分的" | "未着手";

export type CoverageEntry =
  | { readonly block: string; readonly state: "完了"; readonly note?: string }
  | {
      readonly block: string;
      readonly state: "部分的";
      readonly remaining: string;
      /**
       * **残っている項目の構造化された一覧**（cycle 36 step 5 で追加）。
       *
       * ## なぜこれが要るか（部の見出しを持たない主張への手当て）
       *
       * cycle 34 step 5 で「`部分的` の欄は本文の部を 1 つ残らず扱っていること」を機械が見るようにした。
       * ところが**本文に部の構造が無い主張には当てられない**——実測で `部分的` 14 件のうち
       * **6 件**（命題 C′・命題 N・命題 C″・命題 W\*・命題 T・命題 W）が これに当たる。
       *
       * **部が無いなら、欄の側に構造を持たせればよい。** 残っている項目を配列で宣言させ、
       * 各項目の文字列が散文にそのまま在ることを機械が見る。これで
       * **その主張に残りがいくつあるかが機械から見える**ようになる。
       *
       * ## これが効くもう 1 つの理由（step 3 が塞げなかった側）
       *
       * cycle 36 step 3 は「散文の中の列挙には構造が無いので数えられない」ことを理由に、
       * **欄の中の要約（「残るのは 2 つ」）を機械で見ることを諦めていた。**
       * この配列があると数えられるので、**要約の数と実際の項目数の食い違いを機械が見られる。**
       * これは cycle 35・36 で 4 件見つかった事故のうち、
       * (1) 命題 R の「残りは 1 つ」・(3) 命題 W\* の「残りは 1 件」と同じ形である。
       */
      readonly remainingItems?: readonly string[];
      /**
       * **部ごとの済み・残り**（cycle 40 step 2 で追加）。
       *
       * ## なぜこれが要るか
       *
       * cycle 39 step 5 が入れた残り段数の検査は、完了でない 16 件のうち **6 件しか数えられなかった。**
       * 数えられなかった 10 件のうち **8 件**は、本文が部（(K1)(K2)… のような小見出し）で
       * 切られている `部分的` の欄である。cycle 34 step 5 の検査は
       * **台帳がその部の記号に触れていること**しか見ていないので、
       * **どの部が済んでいてどの部が残っているかは台帳が持っていなかった。**
       *
       * ここに部ごとの状態を持たせると、**残っている部の数がそのまま残り段数になる。**
       *
       * ## 機械が確かめること
       *
       * 1. 宣言した部の名前の集合が、本文から読み取った部の集合と**過不足なく一致する**こと。
       *    （書き落とせば赤くなり、本文に無い部を書いても赤くなる。）
       * 2. `済み` と書いた部は、**その根拠として実在する Lean の定理を名指す**こと。
       *    根拠を書けないものを済みにする道を塞ぐ。
       *
       * ## 限界（正直に書く）
       *
       * - **`残り` と書いた部が本当に残っているかは確かめられない**（実在しない宣言は名指せない）。
       *   塞げるのは「済み」と言う側だけである。
       * - **名指した定理がその部を本当に閉じているかも確かめられない**（実在だけを見る）。
       *   これは検査 E の `構成で与える` と同じ性質の限界である。
       * - 部の切り方は本文が決めているので、**欄どうしで段数を比べることはできない**
       *   （検査 D の限界と同じ）。
       */
      readonly partStates?: readonly PartState[];
    }
  | { readonly block: string; readonly state: "未着手"; readonly reason: string };

/** 部ごとの状態（cycle 40 step 2）。 */
export type PartState =
  | {
      readonly part: string;
      readonly state: "済み";
      /** その部を閉じた Lean の定理。`lean/` に実在することを機械が確かめる。 */
      readonly witness: string;
    }
  | { readonly part: string; readonly state: "残り"; readonly why: string }
  /**
   * **台帳の散文は済みと書いているが、その部を閉じる宣言を名指せない**（cycle 40 step 2 の実測で出た形）。
   *
   * 部ごとに状態を書かせてみると、**散文が「形式化した」と書いている部の一部について、
   * 実際にどの宣言がそれを閉じたのかを名指せない**ことが分かった。
   * 名指せないものを `済み` と書くと、この検査は「済みの根拠がある」という保証を失う。
   * かといって `残り` と書くと、済んでいるかもしれないものを残りとして数えることになる。
   * **どちらでもない状態を用意して、段数の勘定では残り側へ入れる**（下界であることを崩さないため）。
   */
  | { readonly part: string; readonly state: "証拠なし"; readonly why: string };

/**
 * 初期値は cycle 27 の実測。状態は `lean/README.md` の命題ごとの表を正本として写し、
 * 表に無いもの（本文にしかないブロック）はその場で判定した。
 */
export const FORMALIZATION_COVERAGE: readonly CoverageEntry[] = [
  {
    block: "paper_022_claim_resultant",
    state: "完了",
    note:
      "claim の内容（1 の冪根の組の上の積＝入れ子の終結式）を、本文が明示する d = 2 だけでなく" +
      "**一般の d** について形式化した（PeriodicPointResultant.lean の `nestedRes_eq_tupleProd`）。" +
      "cycle 29 step 1 が壁とした「反復多項式環 $R[z_1]\\cdots[z_d]$ を再帰で作る型」は要らなかった——" +
      "変数を 1 つだけ外へ出す `MvPolynomial.finSuccEquiv` を d 段回せばよい。" +
      "仮定（$z^L-1$ が $K$ 上で分解する）が空でないことも確かめてある" +
      "（$\\mathbb{Q}$・L = 2・d = 3 で積が $2^3=8$ 項を走る: `nestedRes_rat_two_three`）。" +
      "定義そのもの（$a_L$ が Galois 不変で整数であること、単項式倍で不変であること）は" +
      "この claim ではなく直前の definition ブロックの内容なので対象外。" +
      "なお PropV.lean は $a_L$ を終結式そのものとして定義したうえで " +
      "$a_{p^n}\\equiv P(1,\\dots,1)^{p^{dn}}\\pmod p$ を d = 1, 2 で証明している。",
  },
  {
    block: "paper_031_theorem_lsw",
    state: "未着手",
    reason:
      "エントロピー＝Mahler 測度（Lind–Schmidt–Ward）は本論文の外の既知定理であり、本論文は引用しかしていない。" +
      "**mathlib の欠落は「Mahler 測度が無い」ではなく「多変数の Mahler 測度が無い」である**" +
      "（2026-08-03 実測。lean/README.md と同じ 3 段の引き方、mathlib `520045ab14` の 8264 ファイル: " +
      "連結語 `MahlerMeasure` 3 件・語幹 `mahler` の内容 5 件・ファイル名 3 件。" +
      "`Mathlib/Analysis/Polynomial/MahlerMeasure.lean` は 1 変数 `ℂ[X]`、" +
      "`Mathlib/NumberTheory/MahlerMeasure.lean` は 1 変数 `ℤ[X]` で、" +
      "**どちらも `MvPolynomial` を 1 度も使っていない**）。" +
      "本論文が要るのは 2 変数のスペクトル曲線の Mahler 測度なので、そこから要る。",
  },
  {
    block: "paper_041_theorem_periodicity",
    state: "完了",
    note: "命題 A (1)(2)(3)。(4) は計算可能性の主張であって命題ではないので対象外。",
  },
  {
    block: "paper_042_theorem_pi_p1",
    state: "完了",
    note: "命題 B の訂正後のステートメントについて等式・両方向。原ステートメントが偽であることも形式化してある。",
  },
  {
    block: "paper_043_theorem_bound",
    state: "完了",
    note: "命題 C の整除方向。等号は人手証明のとおり一般に偽なので形式化対象ではない。",
  },
  {
    block: "paper_043b_theorem_trace_bound",
    state: "部分的",
    remaining:
      "命題 C′ は cycle 29 から cycle 48 まで 20 サイクル積み上げた。" +
      "上界の主張そのもの（`TracePeriodAssembly.lean` の tracePeriod_propC_bound）、" +
      "$w^*$ の定義（`WStarElementaryDivisors.lean`）、$w^*=0$ の判定" +
      "（`PropCWStarZero.lean` の wStar_eq_zero_iff_not_dvd_det）、" +
      "$\\rho\\bmod p$ の分離性との同値（`PropCDiscSeparable.lean`）、" +
      "$\\det G$ の分解（`WStarGramDiscriminant.lean`・`ProductAlgebraNorm.lean`・" +
      "`PropCCrtWiring.lean`・`PropCMuComponent.lean`）、そして最後に " +
      "2 つの判別式（冪基底のトレース形式の Gram 行列式 `Algebra.discr` と" +
      "多項式の判別式 `Polynomial.discr`）の同定が入った。" +
      "**同定は 2 段に分かれ、cycle 47 step 1 が判別式とノルムの関係を" +
      "分離性も体も使わずに書き（`PropCDiscrIdentification.lean` の " +
      "discr_eq_sign_mul_norm_derivative）、cycle 48 step 1 が終結式とノルムの同定を書いた**" +
      "（`PropCResultantNorm.lean` の norm_aeval_eq_resultant / " +
      "algebra_discr_eq_polynomial_discr）。" +
      "**この最後の段は mathlib に無かった**（2026-08-05 実測、" +
      "`lean/logs/mathlib-gap-survey-cycle48-resultant-norm.log`。" +
      "走査 script は `lean/scripts/mathlib-gap-survey-cycle48-resultant-norm.sh`。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、" +
      "「終結式と剰余環のノルムの同定」は 3 段とも 0 件、" +
      "`Algebra.discr` と `Polynomial.discr` を結ぶ連結語も 0 件である。" +
      "**語幹で 1 件当たるが、当たっているのは終結式の章そのもの**なので、" +
      "同じ script でその章を宣言行で直読した——`Algebra.norm` の出現は 0 件である。根の像の積として述べた " +
      "`resultant_eq_prod_roots_sub` は $\\rho$ が分解することを要求するので " +
      "$\\mathbb{Z}[x]$ の側には当たらない）。道具の側（`sylvesterMap` と " +
      "`Polynomial.modByMonic`）は在り、cycle 47 が見立てた道——モニック除法で " +
      "Sylvester 写像をブロック三角にする——はそのまま通った。" +
      "**ただし途中で 1 つ、mathlib に無いものが出た**——モニック除法の**商**が $R$ 線形であること" +
      "（同じ実測。`divByMonicHom` は 3 段とも 0 件で、宣言行を直読すると " +
      "`divByMonic` について在るのは次数の補題と写像の可換性だけであり、" +
      "加法性・スカラー倍を述べたものは無い。余りの側 `Polynomial.modByMonicHom` だけが在る）。" +
      "$\\mathbb{R}$ へも $\\overline{\\mathbb{Q}}$ へも出ない（$\\rho$ の根を 1 度も使わない）。" +
      "なお単因子の整除の鎖 $a_1\\mid a_2\\mid\\cdots$ は mathlib に無いままだが" +
      "（`Ideal.smithCoeffs` は在るが係数どうしの整除を述べた宣言は無い）、" +
      "**cycle 45 step 2 でそれを要さない道が見つかっているので、$w^*=0$ の判定には要らなかった。**" +
      "**それでもこの主張は完了しない。書いてみて、外側に段が 1 つ現れた。そう書く**——" +
      "**本文は $w^*$ を「$G$ の最大単因子 $e_r$ の $p$ 進付値」と、単因子の鎖の言葉で定義している。** " +
      "Lean 側の $w^*$（`WStarElementaryDivisors.wStarOfCoeffs`）は適合基底の係数の $p$ 進付値の" +
      "最大値であり、鎖を経由しない。**2 つが同じ数であることは書いていない。** " +
      "`TracePeriodWStarLift.lean` は cycle 37 からこれを残りとして挙げていたが、" +
      "**この欄は 1 度も残り項目として数えていなかった**" +
      "（cycle 45 step 1 が塞いだ数え落としとも、cycle 47 step 2 が見つけた経路とも違う——" +
      "散文は単因子に触れており、検査 J も 検査 L も、欄が 完了 でない限り緑のままだった。" +
      "**完了 と書いた瞬間に 検査 L が捕まえた。**そう書く）。" +
      "鎖の存在そのものは整数行列の Smith 標準形であり、mathlib に無いと実測されている側である" +
      "（`lean/logs/mathlib-gap-survey-cycle41-engines.log`）。" +
      "**したがってこの主張の残りは 1 件である**——" +
      "本文が $w^*$ を単因子の鎖の言葉（最大単因子 $e_r$ の $p$ 進付値）で書いていることとの一致 である。",
    remainingItems: [
      "本文が $w^*$ を単因子の鎖の言葉（最大単因子 $e_r$ の $p$ 進付値）で書いていることとの一致",
    ],
  },
  {
    block: "paper_044_theorem_newton",
    state: "部分的",
    remaining:
      "命題 N は下界方向のみ。上界方向は Skolem–Mahler–Lech / Strassmann が mathlib に無く" +
      "（2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle29.log`。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、`SkolemMahlerLech` 連結語 0 件・" +
      "語幹 `skolem` は 30 件当たるがログが挙げている先はモデル理論の Skolem 関数" +
      "（ログの一覧は先頭 8 件までなので、30 件すべてを見たわけではない）、" +
      "`Strassmann` は 3 段とも 0 件、" +
      "`NewtonPolytope` / 語幹 `newton polytope` も 3 段とも 0 件）、" +
      "鋭い下界は Newton 恒等式の行列トレースへの接続が要り、Newton 多角形と固有値の接続は " +
      "$\\overline{\\mathbb{Q}_p}$ の付値が要る。" +
      "**残りは 3 つである。**",
    remainingItems: [
      "上界方向は Skolem–Mahler–Lech / Strassmann が mathlib に無く",
      "鋭い下界は Newton 恒等式の行列トレースへの接続が要り",
      "Newton 多角形と固有値の接続は ",
    ],
  },
  { block: "paper_045_theorem_lte", state: "完了", note: "命題 L の 4 分岐すべて。" },
  {
    block: "paper_045_theorem_trace_ladder",
    state: "部分的",
    remaining:
      "命題 C″ は核と反例、cycle 27 で加えた $g_m\\ge m+1$ の持ち上げ、および cycle 29 で加えた " +
      "(2) 改良した上界（tracePeriod_dvd_pow_mul）と (4) 閉形式が存在しないことの主張そのもの" +
      "（no_affine_trace_period_exponent。本文の $t_k=1,2,2,4,8,16$ も tThree_values で出した）まで。" +
      "残るのは (1) のしきい値 $w^*+1$ の最良性と (3) の $e_k=\\min\\{m:g_m\\ge k\\}$ の同値。" +
      "cycle 29 step 3 で $w^*$ の定義そのものは入った（WStarElementaryDivisors.lean。" +
      "**「整数行列の単因子が mathlib に無いから書けない」という step 1 の判定は覆った**——" +
      "適合基底の係数の $p$ 進付値の最大値として書ける）。" +
      "残っているのは、その $w^*$ をトレース列の周期の主張へ結ぶ段である（命題 C′ と同じ壁）。**cycle 37 step 3 でその段を書いた**（`TracePeriodWStarLift.dvd_of_mulVec_dvd_of_isPLevel`。詳しくは 命題 C′ の欄を見よ）。**したがってこの主張の残りは 2 つである**——(1) のしきい値 $w^*+1$ の最良性と (3) の $e_k=\\min\\{m:g_m\\ge k\\}$ の同値。" +
      "**cycle 38 step 3 で (3) を書いた**（`TracePeriodStructure.tracePeriod_eq_pow_mul`）。芯は本文が 1 文で書いているとおりで、**$p^m\\tau$ がレベル $k$ の周期であることと $g_m\\ge k$ は同じ文である**——$g_m$ は $\\min_N v_p(\\operatorname{Tr}(S^N(S^{p^m\\tau}-I)))$ なので、$g_m\\ge k$ は「すべての $N$ で $p^k$ が割る」であり、それが `IsTracePeriodAt` の定義そのものである。書く必要があったのは、そこから**最小周期 $t_k$ が $p^{e}\\tau$ に一致する**ことで、$t_k\\mid p^{e}\\tau$（最小性）と $\\tau\\mid t_k$（レベル $1$ の最小周期が割る）から $t_k=p^{m}\\tau$（$m\\le e$）と書け、それが周期なので $g_m\\ge k$、$e$ の最小性で $e\\le m$ となる。**ここで初めて $p$ の素数性を使う。そう書く**——$u\\mid p^{e}$ から $u=p^{m}$ を出す段が要求する（`Nat.dvd_prime_pow`）。`PropCTracePeriod.lean` と本文は「階段の証明は素数性を使っていない」と書いており、それは正しい。素数性を要求しているのは階段ではなく**最小周期の形を決める段**である。**残りは 1 つになった**——(1) のしきい値 $w^*+1$ の最良性（$k\\le w^*$ で階段が偽であること）。**これは反例の族を作る主張であり、本文も反例を明示していない。そう書く。** また $g_m$ を付値の最小として構成する段は書いておらず、$g$ は同値を与える族として受け取っている。" +
      "**cycle 40 step 3 で (1) の最良性を書いた**（`TracePeriodThresholdSharp.lean`）。" +
      "**本文が反例を挙げていなかったので、まず反例を探した**——成分が $-4$ から $4$ までの $2\\times2$ 整数行列と " +
      "$p\\in\\{2,3,5\\}$ を総当たりすると 394 件見つかり、そのうち成分が最も小さいものは " +
      "$S=\\begin{pmatrix}-2&-1\\\\-1&0\\end{pmatrix}$、$p=2$ である。" +
      "このとき $G=\\begin{pmatrix}2&-2\\\\-2&6\\end{pmatrix}$ の単因子は $2,4$ なので $w^*=2$ であり、" +
      "$t_2=1$・$t_3=4$ で $k=2\\le w^*$ では $t_3\\nmid p\\,t_2=2$ となる（`ladder_fails_at_two`）。" +
      "**本文にもこの反例を書き足した**（日英）——主張の内容は変えておらず、witness を明示しただけである。" +
      "形式化の芯は、$S$ が特性多項式 $x^2+2x-1$ を満たすので $a_N=\\operatorname{Tr}S^N$ が " +
      "$a_{N+2}=-2a_{N+1}+a_N$ に従い、**差 $a_{N+t}-a_N$ も同じ漸化式に従うので $N=0,1$ の 2 つで判定が済む**ことである" +
      "（$r=2$ であることの効きどころ）。$w^*=2$ は、行列式 $1$ の行列で挟むと $\\mathrm{diag}(2,4)$ になることで与えた。" +
      "**書いてみて分かったことが 1 つある。そう書く**——`IsTracePeriodAt` は係数環が可換であることを要求するので、" +
      "**行列環にはそのまま当たらない。** 本文の $\\operatorname{Tr}(S^N(S^t-I))$ は $a_{N+t}-a_N$ そのものなので、" +
      "数列の側の `IsPeriodMod` で述べた（内容は同じである）。" +
      "**残りは 2 つである**——全ての $k$ で破れる形（反例が示すのはしきい値をこれ以上下げられないことまでで、" +
      "$k$ ごとに破れるかは $S$ に依る。この $S$ では $k=1$ では破れていない）と、" +
      "一般の $T$ についての配線（Gram 行列が $(\\operatorname{Tr}T^{i+j})$ であることを、この file では数値で与えている）。" +
      "**cycle 45 step 1 の全数の数え直しで、この欄が名指ししながら数えていなかった事柄が 1 つ見つかった**——" +
      "上の「$g_m$ を付値の最小として構成する段は書いておらず」がそれである。" +
      "散文は cycle 40 からこれを名指ししていたが、残り項目の配列には入っていなかった。" +
      "**残りは 3 つである。**",
    remainingItems: [
      "全ての $k$ で破れる形",
      "一般の $T$ についての配線",
      "$g_m$ を付値の最小として構成する段",
    ],
  },
  {
    block: "paper_046_theorem_wstar_different",
    state: "完了",
    note:
      "cycle 28 で 3 段のうち 2 段を形式化した（PropWStarDifferent.lean）。" +
      "微分の段（$\\chi'=h\\cdot\\sum_i a_i f_i'(\\rho/f_i)$）と、" +
      "付値の段（$\\min\\{j:\\forall\\mathfrak p,\\ j\\,e_\\mathfrak p\\ge v_\\mathfrak p\\}" +
      "=\\max_\\mathfrak p\\lceil v_\\mathfrak p/e_\\mathfrak p\\rceil$、および従順分岐・不分岐の系）である。" +
      "cycle 29 step 3 で双対の段の大半が入った（WStarElementaryDivisors.lean）。" +
      "**step 1 の仕分けが「素材が無い（整数行列の Smith 標準形が無い）」と判定したのは誤りだった。** " +
      "整除の鎖は確かに無いが $w^*$ に鎖は要らず、適合基底の係数の $p$ 進付値の最大値で書ける。" +
      "入ったのは (a) $w^*=\\min\\{j:\\ p^j\\eta^{-1}\\in A_{(p)}\\}$ の右辺が意味をもち" +
      "最小元が適合基底の係数で書けること（isLeast_isPLevel_ideal / exists_isPLevel_ideal）、" +
      "(b) **本文の $\\det G=\\pm N_{A/\\mathbb{Q}}(\\eta)$**（det_weightedGram。" +
      "重み付き Gram 行列がトレース形式の Gram 行列と $\\mu$ 倍の行列の積に分解することと、" +
      "判別式が $\\rho'(\\theta)$ のノルムに等しいことから）、" +
      "(c) **Euler の双対基底公式を行列の等式にしたもの** $C\\,G=M_\\eta$ と $(\\det C)^2=1$" +
      "（eulerMatrix_mul_weightedGram / det_eulerMatrix_sq。" +
      "心臓部は $\\operatorname{Tr}(c_i w)=[\\theta^i](\\rho'(\\theta)w)$＝trace_coeff_minpolyDiv_mul）、" +
      "(d) 可逆な取り替えで像に対する $p$ 進の条件が変わらないこと（isPLevel_range_comp）。" +
      "cycle 30 step 1 で **(1) 整数への降下が入った**（WStarIntegralDescent.lean）。" +
      "cycle 29 が予定していた道（`coeff_minpolyDiv_mem_adjoin` で所属を言い、座標へ翻訳する）ではなく、" +
      "**$C$ の成分が $\\rho$ の係数そのもの $C_{ij}=\\rho_{i+j+1}$ である**ことを等式で書いた" +
      "（coeff_minpolyDiv_eq_sum / eulerMatrix_eq_eulerHankel）。" +
      "したがって $C$ は反対角線が $\\rho_r=1$ の Hankel 行列で、$\\det C=\\pm1$ が三角行列の行列式ひとつで出る" +
      "（isUnit_det_eulerHankel。可換環の上で成立し、体も分離性も既約性も使わない）。" +
      "「行列の像と $\\eta A$ を基底で同一視する配線」も入った" +
      "（range_mulLeft_eq_span / isLeast_isPLevel_range_of_euler）。" +
      "これで人手証明の「$\\operatorname{coker}(G)\\cong A/\\eta A$ だから $G$ の単因子は $A/\\eta A$ の不変量」が" +
      "$C\\,G=M_\\eta$ を仮定として与えたときに Lean で通る。" +
      "**cycle 30 から cycle 35 まで、この欄はここに「残りは可約な $\\rho$ での $C\\,G=M_\\eta$ そのもの 1 件だけである」と書いていた（その判断は cycle 36 step 1 の実測で覆った。下記）。** " +
      "(b)(c) は `PowerBasis K L`（$L$ は体）を使っており $\\rho$ が既約な場合しか覆っていない。" +
      "$\\rho$ が可約なとき $A\\otimes\\mathbb{Q}$ は体でなく体の積である。" +
      "**これは配線の欠落ではなく素材の欠落である**（2026-08-04 実測、" +
      "`lean/logs/mathlib-gap-survey-cycle30-euler.log`。mathlib 8264 ファイル走査で" +
      "可換環の上のトレース双対・双対基底・Euler の双対基底公式・Frobenius 代数はいずれも連結語 0 件、" +
      "実在する `Module.Basis.traceDual` は宣言が `[Field K] [Field L] [FiniteDimensional K L] " +
      "[Algebra.IsSeparable K L]` を要求していることを宣言行で直接確認した）。" +
      "埋めるには可換環の上の Euler の双対基底公式 " +
      "$\\operatorname{Tr}_{A/R}(c_i\\theta^j)=\\delta_{ij}$ を自前で書くことになる。" +
      "**cycle 36 step 1 でそれを書き、外部定理の側は完了した**（`EulerDualBasisCommRing.lean` の " +
      "段 2–5 と、本文の $C\\,G=M_\\eta$ の可換環版 `eulerMatrix_mul_weightedGram`。" +
      "$C$ が $\\rho$ の係数の Hankel 行列であること `eulerMatrix_apply` も可換環の上で書いたので、" +
      "`isUnit_det_eulerHankel` と繋いで $\\det C=\\pm1$ も出る）。" +
      "**それでもこの主張は完了しない。cycle 36 step 1 の実測で、残りが 1 件ではなかったことが分かった。** " +
      "台帳は cycle 30 から「残っているのは 1 つ、可約な $\\rho$ での $C\\,G=M_\\eta$ そのもの」と書き続けていたが、" +
      "その 1 件を埋めても下流が塞がったままだった。**実測で見つかった穴は 3 件で、うち 1 件は本 step で埋めた。残っているのは 2 つである。** " +
      "(1) **降下そのものが整域を要求していた**——`WStarIntegralDescent.isLeast_isPLevel_range_of_euler` は " +
      "`[IsDomain S]` を仮定しており、$\\rho$ が可約なとき $A=\\mathbb{Z}[x]/(\\rho)$ は整域でないので当たらない。" +
      "**cycle 36 step 1 でこれは埋めた**（`WStarReducibleDescent.lean` の " +
      "`exists_isLeast_isPLevel_range_of_euler`。整域は本質でなく $\\eta$ が零因子でないことへ落ちる。" +
      "適合基底は `Submodule.exists_smith_normal_form_of_rank_eq` で作れて、PID を要求されるのは係数環 " +
      "$\\mathbb{Z}$ の側だけである）。" +
      "(2) **$\\det G=\\pm N_{A/\\mathbb{Q}}(\\eta)$ が可約な場合に無い**——`det_weightedGram` は " +
      "`PowerBasis K L`（$L$ は体）で書かれており、本文の 2 つめの等式は既約な場合しか覆っていない" +
      "（2026-08-05 実測、宣言行で直読）。**未形式化である。**" +
      "(3) **$\\eta=(\\chi\'/h)(\\theta)$ が零因子でないこと**と、$A=\\mathbb{Z}[x]/(\\rho)$ が " +
      "`IsPowerBasisOf` / `IsReductionOf` を満たすことの当てはめ。どちらも仮定として受け取っている。" +
      "**cycle 37 step 1 で、この 2 件のうち 1 件を完全に埋め、もう 1 件を半分だけ埋めた。残るのは 1 つである。** " +
      "(2) は埋まった——**判別式を経由しなければ体は要らない**。段 6 の $C\\,G=M_\\eta$ の両辺の行列式を取り、" +
      "$\\det C=\\pm1$（$C$ が $\\rho$ の係数の Hankel 行列であることから出る。`det_eulerHankel_sq` を " +
      "`sign_mul_det_eulerHankel` から $2$ 乗の形で取り出した）を使うと、$\\det M_\\eta$ はノルムの定義そのものなので " +
      "$\\det G=\\pm N_{A/R}(\\eta)$ が可換環の上で出る（`EulerDualBasis.det_weightedGram`）。" +
      "体も整域も分離性も既約性も使わない。**体の上の証明が体を要求していたのは判別式を経由していたからで、" +
      "経由しなければ落ちる**——これは cycle 35 で段 1 について分かったことと同じ形である。" +
      "(3) の後半（冪基底の仮定の当てはめ）も埋まった（`WStarPowerBasisInstance.lean` の " +
      "`isPowerBasisOf_adjoinRoot` / `isReductionOf_adjoinRoot`。$A=R[x]/(\\rho)$ について、" +
      "中身は $\\rho(\\theta)=0$ とモニック多項式の展開だけである）。" +
      "**残っているのは (3) の前半、$\\eta$ が零因子でないことだけである。** " +
      "**ただしそれも半分は埋まった**——$\\eta$ が零因子でないことは $N(\\eta)\\neq0$ と同値であり" +
      "（`EulerDualBasis.norm_ne_zero_iff_mem_nonZeroDivisors`。$A$ は整域でなくてよい。" +
      "mathlib の `Algebra.norm_ne_zero_iff` は $A$ が整域であることを要求するので、そのままでは使えない）、" +
      "段 7 と合わせると $\\det G\\neq0$ から出る" +
      "（`WStarPowerBasis.mem_nonZeroDivisors_of_det_weightedGram_ne_zero`）。" +
      "**したがって `WStarReducibleDescent` が置いた「$\\eta$ は零因子でない」は余計な仮定ではなく、" +
      "本文が主張している $\\det G\\neq0$ と同じ事柄である。** " +
      "**残るのは、$\\rho=\\mathrm{rad}(\\chi)$ が無平方であることから $\\det G\\neq0$ を出す段である。" +
      "これは未形式化であり、そう書く。** " +
      "止めた理由は素材である（2026-08-05 実測）——この段は $\\rho$ の無平方性を " +
      "$\\mathbb{Z}[x]$ から $\\mathbb{Q}[x]$ へ移す Gauss 型の移送を要するが、" +
      "mathlib にその形の補題は無い（2026-08-05 実測、" +
      "`lean/logs/mathlib-gap-survey-cycle37-squarefree.log`。mathlib `520045ab14` の 8264 ファイルを " +
      "3 段で引き、`squarefree_map` / `Squarefree.isFractionRing` / `Monic.squarefree_map_iff` が " +
      "いずれも 3 段とも 0 件。`GaussLemma.lean` と `Content.lean` に `Squarefree` は 1 行も現れない）。" +
      "素材そのもの（`Monic.dvd_iff_fraction_map_dvd_fraction_map` と " +
      "`IsIntegrallyClosed.eq_map_mul_C_of_dvd`）は在るので、自前で書ける見込みはある。" +
      "**cycle 38 step 1 でその段を書いた**（`WStarSquarefreeNonzero.lean`）。" +
      "**cycle 37 の実測（Gauss 型の移送が mathlib に無い）は正しく、" +
      "誤っていたのは「だから書けない」という推論のほうである**——" +
      "同じログが名指しした素材から、移送そのものは自前で 1 本書ける" +
      "（`Monic.squarefree_map`。$g^2\\mid f_K$ の $g$ をモニックに正規化し、" +
      "`IsIntegrallyClosed.eq_map_mul_C_of_dvd` で $R[x]$ の元の像に直してから、" +
      "`Monic.dvd_of_fraction_map_dvd_fraction_map` で $R[x]$ の中の $h'^2\\mid f$ に落とす）。" +
      "そこから $\\rho_K$ が分離的（$K$ は標数 $0$ なので完全体）$\\Rightarrow$ " +
      "$\\rho_K$ と $\\rho_K'$ が互いに素 $\\Rightarrow$ $\\rho\\mid\\rho'g$ ならば $\\rho\\mid g$ " +
      "（`dvd_of_dvd_derivative_mul`）$\\Rightarrow$ $A=R[x]/(\\rho)$ で $\\rho'(\\theta)$ が零因子でない" +
      "（`derivative_mem_nonZeroDivisors`）$\\Rightarrow$ 段 7 と繋いで $\\det G\\neq0$" +
      "（`det_weightedGram_ne_zero_of_squarefree`）と進む。" +
      "**$R[x]$ へ戻す段に原始性（したがって `IsGCDMonoid`）は要らなかった**——" +
      "$\\rho$ がモニックなので余りつき除算が $R[x]$ の中でできて、余りの像が $0$ なら余りも $0$ である。" +
      "**それでもこの主張は完了しない。書いてみて、残りが 1 件ではなかったことが分かった。** " +
      "本 step が書いたのは「$\\rho$ が無平方かつ $\\mu$ が零因子でないならば $\\det G\\neq0$」という" +
      "**含意**であって、その 2 つの仮定は受け取っている。**本文はどちらも構成で与えている**ので、" +
      "構成そのものを書かないと主張の形にならない。**残りは 2 つである。** " +
      "(i) $\\rho=\\mathrm{rad}(\\chi)$（$\\chi$ の相異なる既約因子の積）の構成と、それが無平方であること。" +
      "(ii) $\\mu$（$\\chi=\\prod_i f_i^{a_i}$ の重複度 $a_i$ を成分ごとにとる元。" +
      "本文の $\\chi'/h=\\sum_i a_i f_i'\\,\\rho/f_i$ がその実体）の構成と、それが零因子でないこと。" +
      "**この 2 つは cycle 37 までの残り一覧に 1 度も現れていない。** " +
      "現れなかったのは、台帳が「$\\det G\\neq0$ を出す段」を含意として読んでいて、" +
      "その両端が構成であることを数えていなかったためである。" +
      "**cycle 35・36 で 2 度起きた「入ってみたら残りは 1 件ではなかった」の 3 度目である。そう書く。** " +
      "**cycle 39 step 3 でその 2 つを書いた**（`WStarRadicalMultiplicity.lean`）。" +
      "(i) は `squarefree_rad` と `rad_monic`——相異なる素元は共通の非単元因子を持たず、素元は無平方なので、その積も無平方である。" +
      "(ii) は `multWeight`（本文の $\\sum_i a_i f_i'\\,\\rho/f_i$ そのもの）と `multWeight_mem_nonZeroDivisors`——" +
      "$f_i$ を法にとると $\\mu\\equiv a_i f_i'\\,(\\rho/f_i)$ であり、$f_i$ は素元なので割るなら " +
      "$a_i$・$f_i'$・$f_j\\ (j\\neq i)$ のどれかを割ることになるが、次数の比較と素元の相異性からどれも起こらない。" +
      "併せて本文の $\\chi=h\\rho$ と $\\chi'=h\\mu$ も書いた（`chi_eq_lower_mul_rad` / `derivative_chi_eq_lower_mul_multWeight`）。" +
      "**この 2 つを与えると $\\det G\\neq0$ が仮定を 1 つも残さずに出る**（`det_weightedGram_ne_zero_of_factorization`）。" +
      "**書く途中で、最初に置いた仮定の形が誤りだったことが分かって直した。そう書く**——" +
      "相異なる因子の条件を最初は `IsCoprime`（Bézout の関係）で書いたが、" +
      "**$\\mathbb{Z}[x]$ は単項イデアル整域ではないので、相異なる素元でも Bézout は立たない**" +
      "（$x$ と $x+2$ について $ux+v(x+2)=1$ を $x=0$ で見ると $\\mathbb{Z}$ で $2v(0)=1$ となり不可能である）。" +
      "本論文が当てるのは $\\mathbb{Z}[x]$ なので、その形では仮定を満たす族が存在しない。" +
      "共通の非単元因子を持たないこと（`IsRelPrime`）へ直した。" +
      "**それでもこの主張は完了しない。書いてみて、また残りが外側にあることが分かった。そう書く**——" +
      "本ファイルは族 $f_i$ と重複度 $a_i$ を**受け取って** $\\rho=\\prod_i f_i$ を作っているが、" +
      "**本文は $\\rho=\\mathrm{rad}(\\chi)$ と $\\chi$ から定義している。** " +
      "したがって $\\chi$ から族を取り出す段（一意分解と、モニックな $\\chi$ の因子がモニックに取れること）が残る。" +
      "**「残りが N 件」と書かれた欄に入ると N 件ではない、が 4 サイクル続いたことになる**（cycle 35・36・38・39）。" +
      "**cycle 40 step 1 でその 1 件を書いた**（`WStarFactorExtraction.lean`）。" +
      "一意分解の因子をモニック化し（素因子の先頭係数は $\\chi$ がモニックなことから単元である）、" +
      "同じものを数え上げて重複度にする（`exists_monic_prime_factorization`）。" +
      "相異なることの中身は「同伴なモニック多項式は等しい」で、" +
      "$\\chi$ を当てる先（整数行列の特性多項式）まで書いた（`exists_radical_and_multWeight_charpoly`）。" +
      "**それでもこの主張は完了しない。書いてみて、今度は残っているものの中身が違うことが分かった。そう書く。** " +
      "**cycle 39 が記号を取り違えていた**——cycle 39 の `multWeight` は $\\chi'/h$ であり、" +
      "**本文の記号では $\\eta$ である**（本文の証明の第 1 段落が $\\eta=\\mu\\,\\rho'(\\theta)$ と書いており、" +
      "本文の $\\mu$ は成分 $K_i=\\mathbb{Q}[x]/(f_i)$ ごとに重複度 $a_i$ をとる別の元である。2026-08-05 に本文を直読して確かめた）。" +
      "**本文の $G$ は重みを $\\mu$ にとった Gram 行列 $\\langle x,y\\rangle=\\operatorname{Tr}(\\mu xy)$ なので、" +
      "cycle 38・39 が $\\det G\\neq0$ と書いてきたものは、重みを $\\eta$ にとった別の行列についての主張である。** " +
      "どちらも真だが同じ主張ではない。**`EulerDualBasis.det_weightedGram` は重み $\\mu_A$ について " +
      "$\\det=\\pm N(\\rho'(\\theta)\\mu_A)$ を与えるので、本文の等式 $\\det G=\\pm N(\\eta)$ は " +
      "$\\mu_A$ に本文の $\\mu$ を入れたときの形である。** " +
      "**残りは 2 つである。** " +
      "(i) 本文の $\\mu$ の構成と $G$ の同定" +
      "（成分ごとに $a_i$ をとる元は $A_\\mathbb{Q}$ に住み、本文の $G$ はその重みの Gram 行列である）。" +
      "(ii) $w^*$ の等式を組み立てる段（$\\chi=\\chi_T$ について 1 本にまとめる）" +
      "（部品は揃っているが、`exists_isLeast_isPLevel_range_of_euler` へ当てる形にはなっていない）。" +
      "**cycle 41 step 1 で (i) の前半（$\\mu$ の構成）を書いた**（`WStarMuGram.lean`）。" +
      "$\\rho$ が無平方なら $\\rho'(\\theta)$ は $A_\\mathbb{Q}$ の単元なので、$\\eta$ をそれで割れば $\\mu$ が作れる" +
      "（`mu` / `derivative_mul_mu`）。本文が「成分 $K_i$ 上で $a_i\\rho'(\\theta_i)$ に等しい」と書いている段も、" +
      "$f_i$ を法にとった多項式の合同として書いた（`aeval_multWeight_eq_on_component`）。" +
      "**その $\\mu$ を入れると、本文の statement の 2 本目の等式 $\\det G=\\pm N(\\eta)$ が" +
      "$\\rho$ と $\\eta$ だけから出る**（`det_weightedGram_mu_of_squarefree`）。" +
      "**それでもこの項目は閉じない。残っているのは (i) の後半である。そう書く**——" +
      "**本文の $G$ は整数行列 $(\\operatorname{Tr}T^{i+j})$ であり**（定義は 命題 C′ の statement）、" +
      "Lean 側の `EulerDualBasis.weightedGram` は代数のトレースで書いた行列なので、" +
      "2 つが同じ行列であることは $\\operatorname{Tr}T^N=\\operatorname{Tr}_{A_\\mathbb{Q}/\\mathbb{Q}}(\\mu\\theta^N)$" +
      "（$\\chi$ の根の $N$ 乗和）に他ならない。**cycle 41 step 1 はそこへ 1 段寄せた**——" +
      "両辺が $\\chi$ の与える同じ線形漸化式に従うことを書いたので" +
      "（`psi_eta_recurrence` / `trace_pow_recurrence`）、残るのは初期値 $N=0,\\dots,\\deg\\chi-1$ の一致だけである。" +
      "**その一致は $\\chi$ の係数から冪和を出す関係（Newton の関係）そのものである。** " +
      "**cycle 41 step 1 はここに「mathlib にその形は無い」と書いたが、同じサイクルの step 4 の走査で言い過ぎだと分かった。そう書く**——" +
      "Newton の関係そのものは在る（`MvPolynomial.psum` と `psum_eq_mul_esymm_sub_sum`。" +
      "`lean/logs/mathlib-gap-survey-cycle41-engines.log`）。" +
      "**無いのは「行列のトレースの冪と特性多項式の係数を結ぶ形」のほうである。** " +
      "したがって残っている 1 件は" +
      "「本文の整数行列 $G$ と重み $\\mu$ の Gram 行列の同定（冪和 $\\operatorname{Tr}T^N$ の初期値）」である。" +
      "また段 1 が使う $\\mathbb{Q}[x]$ 側の無平方性（$\\mathbb{Z}[x]$ 側からの降下＝Gauss）は仮定として受け取っている。" +
      "**書いてみて外側に段が 1 つ現れたので、いま残りは 3 件である。そう書く**——" +
      "3 件目が「$\\mathbb{Q}[x]$ 側の無平方性への降下（Gauss）」である。" +
      "本文は $\\rho$ の無平方性を $\\mathbb{Z}[x]$ の側で言っており、$\\mu$ の構成が要るのは $\\mathbb{Q}[x]$ の側である。" +
      "cycle 40 step 1 に続いて、**書いた段の外側に段が現れたのは 7 サイクル目である。**" +
      "**cycle 42 step 3 で、cycle 41 step 4 が「在る」と言った Newton の関係を実際に当ててみた。" +
      "当たらなかった。そう書く**（2026-08-05 実測）——mathlib の Newton の関係" +
      "（`MvPolynomial.psum` / `psum_eq_mul_esymm_sub_sum`）は" +
      "**形式的な対称式の世界の恒等式であり、行列の特性多項式の係数へ渡す宣言が無い**。" +
      "`Matrix.trace_pow` は 0 ファイル、`Matrix.trace_eq_sum_roots_charpoly` は $N=1$ だけで" +
      "しかも代数閉体を要求する。**在ることと当たることは別である**——" +
      "当たらない理由は「無い」ではなく「橋が無い」であり、渡すには根を分解体で取り出す段が要る。" +
      "**代わりに橋の半分を架けた**（`WStarTracePowerBridge.lean`）——" +
      "同定は (1) 代数側のトレースを行列のトレースへ移すことと " +
      "(2) $T$ と $M_\\mu M_\\theta$ の関係を結ぶことに分かれ、**書いたのは (1) である**" +
      "（`trace_mul_pow_eq_trace_leftMulMatrix` / `weightedGram_apply_eq_matrix_trace`。" +
      "$z\\mapsto M_z$ が $R$ 代数の準同型なので積とも冪とも交換する。$\\mathbb{R}$ へも " +
      "$\\overline{\\mathbb{Q}}$ へも出ない）。**したがって残りは、本文が「Newton の公式より」と引いている " +
      "「同じ特性多項式をもつ 2 つの行列のトレース冪が一致すること」そのものになった。** **成分ごとの分解は cycle 42 step 1 が測った中国剰余の壁と同じものである。**" +
      "**cycle 43 step 5 で 2 つの道を測り、可算側で閉じる分を書いた**（`TracePowerRecurrence.lean`）。" +
      "**cycle 42 総括が挙げた 2 つの道のうち、$\\overline{\\mathbb{Q}}$ へ出ない側（逆特性多項式の対数微分）は素材が足りない。そう書く**——" +
      "逆特性多項式そのものは在るが（`Matrix.charpolyRev`。定数項が $1$ であることも 1 次の係数がトレースであることも在る）、" +
      "対数微分の段を出すには行列式の微分（Jacobi の公式）が要り、**mathlib に Jacobi の公式は無い**" +
      "（2026-08-05 実測。`Jacobi` で当たるのは Legendre 記号と Jacobi 記号だけである）。" +
      "**そこで Cayley–Hamilton の道で書けるところまでを書いた**——トレース冪が特性多項式の与える線形漸化式に従うこと" +
      "（`sum_coeff_smul_trace_pow`。芯は 2 行で、$\\chi(M)=0$ に $M^{k}$ を掛けてトレースを取るだけである）、" +
      "モニックなので最高次を分離した形（`trace_pow_add_natDegree`）、" +
      "したがって同じ特性多項式をもち最初の $r$ 個が一致すれば全部一致すること（`trace_pow_eq_of_charpoly_eq_of_initial`）である。" +
      "**$\\mathbb{R}$ へも $\\overline{\\mathbb{Q}}$ へも 1 度も出ない**——係数環は任意の可換環で、根も分解体も出てこない。" +
      "**それでもこの項目は閉じない。残ったのは初期値の側である。そう書く**——" +
      "$k<r$ での $\\operatorname{Tr}(M^{k})$ が特性多項式だけで決まることが Newton の公式そのものであり、" +
      "閉じるには Jacobi の公式か、分解体で根を取り出す道（$\\overline{\\mathbb{Q}}$ へ出る）のどちらかが要る。" +
      "**cycle 44 step 3 でその Jacobi の公式を書いた**（`JacobiFormula.lean`）。" +
      "**測ってみて、前サイクルの記録の後半が誤りだったことが分かった。そう書く**——" +
      "「mathlib に Jacobi の公式は無い」という側は正しい（2026-08-05 実測。" +
      "行列式の微分に当たるのは `Matrix.derivative_det_one_add_X_smul` だけで、" +
      "これは $\\det(1+XM)$ の $0$ での微分＝1 次の係数しか与えない）。" +
      "**誤っていたのは「したがって素材が足りない」という側である**——" +
      "要る素材は 3 つとも在った（行列式が行について多重線形であること・余因子展開" +
      "`Matrix.cramer_transpose_apply`・余因子行列 `Matrix.adjugate`）。**書いた量は 25 行である。** " +
      "**これで「書けない理由」として記録されていたものが誤りだった件は 10 件目になる。" +
      "ただし今回の形は前の 9 件と違う**——引き方は正しく、無いという判定も正しかった。" +
      "**誤っていたのは「無いから書けない」という推論のほうである。** " +
      "書いたのは 3 段で、行ごとの形（`derivative_det`）、余因子展開" +
      "（`det_updateRow_eq_sum_adjugate`）、そして対数微分の道が要求している余因子行列の形" +
      "（`derivative_det_eq_trace_adjugate`。$\\mathrm{d}\\det A=\\operatorname{tr}(\\operatorname{adj}(A)A')$）である。" +
      "**$\\mathbb{R}$ へも $\\overline{\\mathbb{Q}}$ へも 1 度も出ない。したがって道の選択は決まった**——" +
      "分解体で根を取り出す道は採らず、対数微分の道を採る。" +
      "**それでもこの項目は閉じない。残っているのは道の長さである。そう書く**——" +
      "$A=1-XM$ に当てて $\\operatorname{adj}(1-XM)$ を形式冪級数へ開く段と、" +
      "係数を取り出して初期値 $\\operatorname{Tr}(M^{k})$（$2\\le k<r$）を読む段の 2 つが残る。" +
      "**cycle 45 step 1 の全数の数え直しで、この欄の数え方を直した**——" +
      "散文はこの 2 つを名指ししているのに、残り項目の配列は「初期値の側」1 つとして数えていた。" +
      "2 つに分けて数える。" +
      "**cycle 45 step 4 でその 2 つを書いた**（`NewtonInitialValues.lean`）。" +
      "**台帳が「形式冪級数へ開く段」と書いていたものは、開かなくてよかった。そう書く**——" +
      "余因子行列の定義式 $\\operatorname{adj}(A)A=(\\det A)I$ に $A=1-X\\widetilde M$ を入れると " +
      "$\\operatorname{adj}(A)=(\\det A)I+X\\operatorname{adj}(A)\\widetilde M$ という" +
      "**多項式の中の漸化式**になり（`adjugate_recursion`）、$\\widetilde M^{k}$ と組んでトレースを取ると " +
      "$T_k=(\\det A)\\operatorname{Tr}(M^{k})+XT_{k+1}$（`trace_adjugate_step`）である。" +
      "$K$ 回展開すれば対数微分の等式が $R[X]$ の中の等式として出る" +
      "（`neg_derivative_charpolyRev_expand`）。**無限和も収束も要らない。** " +
      "係数を読む段も書いた——定数項が $1$ の多項式を掛けても低次の係数の消滅は移る" +
      "（`coeff_eq_zero_of_mul`）ので、$\\det(1-XM)$ の定数項が $1$ であることから" +
      "係数ごとの一致が出る。**結論は本文が「Newton の公式より」と引いている事柄そのものである**——" +
      "特性多項式が同じ 2 つの行列はトレース冪がすべて一致する（`trace_pow_eq_of_charpoly_eq`）。" +
      "**これで cycle 43 step 5 の `trace_pow_eq_of_charpoly_eq_of_initial` が仮定として" +
      "受け取っていた初期値の一致が落ちた。** " +
      "$\\mathbb{R}$ へも $\\overline{\\mathbb{Q}}$ へも 1 度も出ない（係数環は任意の可換環である）。" +
      "**cycle 46 step 1 で残る 2 件を書いた。この主張は完了である。そう書く。** " +
      "(1) $\\mathbb{Q}[x]$ 側の無平方性への降下（Gauss）は**配線だけだった**" +
      "（`WStarGaussDescent.lean`）——cycle 38 step 1 の " +
      "`WStarSquarefree.squarefree_map_of_monic` がその降下そのものであり、" +
      "**書いた側と使う側が 3 サイクルにわたって繋がっていなかった。** " +
      "これは cycle 35・36・40 の「数と実態がずれる」型ではなく、" +
      "**在るものに気付かないまま同じ事柄を仮定として立て直した**型である。" +
      "(2) $w^*$ の等式を組み立てる段は `WStarGramAssembly.lean` で書いた。" +
      "**本文の整数行列 $G=(\\operatorname{Tr}T^{i+j})$ と代数の Gram 行列 " +
      "$(\\operatorname{Tr}_{A_K}(\\mu\\theta^{j+k}))$ が同じ行列であることが、" +
      "$\\operatorname{Tr}T^N=\\operatorname{Tr}_{A_K}(\\mu\\theta^N)$ である" +
      "（`trace_pow_eq_trace_mu_all`）。** " +
      "道は 3 つに分かれた。$\\chi$ を特性多項式にもつ行列を代数の側で作ること" +
      "（$K[x]/(\\chi)$ の冪基底に関する $\\theta$ 倍写像。`charpoly_mulMatrix`）、" +
      "重複度を落とすこと（$\\operatorname{Tr}_{K[x]/(f^a)}(\\theta^N)" +
      "=a\\operatorname{Tr}_{K[x]/(f)}(\\theta^N)$。`trace_pow_adjoinRoot_pow`）、" +
      "そして中国剰余で成分へ分けること（`trace_mu_pow_eq_sum`）である。" +
      "**mathlib に無くて書いたのは 3 本**（一様なブロック対角の特性多項式 `charpoly_blockDiagonal`、" +
      "添字の付け替えでトレースが変わらないこと `trace_reindex`、" +
      "直積代数のトレースの分解 `trace_pi_fin`。いずれも 2026-08-05 実測で 0 件）。" +
      "**ブロックの大きさが揃っていない形（`blockDiagonal\'`）は要らなかった**——" +
      "揃っていない並べ方は代数の側（中国剰余）が引き受けるので、" +
      "cycle 43 step 1 が測った「`blockDiagonal\'` の行列式が無い」という壁に当たらない。" +
      "**$N=0$ の成分だけ道が違う。そう書く**——$T^0$ は単位行列で特性多項式の情報を持たないので" +
      "トレース冪の一致が使えず、次元の勘定で書いた（`trace_mu_eq_card`。" +
      "$\\operatorname{Tr}T^0=r$ と $\\sum_i a_i\\deg f_i=\\deg\\chi=r$）。" +
      "$\\mathbb{R}$ へも $\\overline{\\mathbb{Q}}$ へも 1 度も出ない。",
  },
  {
    block: "paper_051_theorem_duality",
    state: "部分的",
    remaining:
      "**cycle 35 step 4 の照合で、この欄が本文の部を全部覆っていないことが分かったので足す**——" +
      "本文は (∞ 素点)・(p 素点, 有限 L)・(p 素点, 塔の漸近) の 3 部に分かれているが、" +
      "この欄は (∞ 素点) という部の名前に 1 度も触れず「アルキメデス側」とだけ書いていた。" +
      "**(∞ 素点) は未形式化である**（下記 (1)）。" +
      "cycle 34 step 5 の検査がこれを見落としていたのは、部の記号を英数字の形でしか拾っていなかったためで、" +
      "この主張のように素点の名前で部を切っているものが素通りしていた。" +
      "cycle 29 で $p$ 素点側の切り出しを実際にやり、**(p 素点, 有限 L) の段**を $d=1$ で形式化した" +
      "（DualityPAdicFiniteL.lean）。入ったのは、本文の簡約周期点数 " +
      "$a^{\\mathrm{red}}_L=\\prod_{\\zeta^L=1,\\ P(\\zeta)\\neq0}P(\\zeta)$ の定義そのもの" +
      "（Lean のどこにも無かった。既存の PropV.lean と PeriodicPointResultant.lean は簡約しない $a_L$ だけを扱う）と、" +
      "$a^{\\mathrm{red}}_L\\neq0$、$a^{\\mathrm{red}}_L=\\mathrm{Res}(h,P)$（$h$ は $X^L-1$ の monic な因子）、" +
      "$h=(X^L-1)/\\gcd(X^L-1,P)$ が $\\mathbb{Z}[X]$ に属すること（Gauss）、" +
      "その $h$ の根がちょうど本文の「良い根」であること、" +
      "したがって $a^{\\mathrm{red}}_L$ が $\\mathbb{Z}$ 係数の終結式ひとつで書ける $0$ でない整数であること" +
      "（＝本文の $v_p(a^{\\mathrm{red}}_L)\\in\\mathbb{Z}_{\\ge0}$ が意味をもつことの中身）である。" +
      "$L=p^n$ の塔の非自明性の判定は PropV.lean が $d=1,2$ で既に持っている。" +
      "残るのは 3 つ。(1) **アルキメデス側**（自由エネルギー密度＝Mahler 測度）。" +
      "命題 LSW と同じ理由で素材が無い——mathlib の Mahler 測度は 1 変数だけで多変数が無い" +
      "（`MvPolynomial.mahlerMeasure` の連結語 grep 0 件。語幹 `mahler measure` の 3 件は" +
      "いずれも 1 変数。lean/logs/mathlib-gap-survey-cycle29-duality.log）。" +
      "しかも本論文はこの段を証明せず外部定理を引用している。" +
      "(2) **(p 素点, 塔の漸近)**。Monsky の定理と Cuoco–Monsky の定理の適用であり、本論文は証明しない。" +
      "素材も無い——`Monsky` / `CuocoMonsky` / `semialgebraic` / $\\mathbb{Z}_p^d$ 拡大は 3 段すべて 0 件、" +
      "岩澤代数は mathlib の p 進測度の章の散文に 1 行触れられているだけ（1 変数の測度）、" +
      "Weierstrass 準備定理は 1 変数版だけ（同じログ、mathlib 8264 ファイル走査）。" +
      "(3) 有限 $L$ の段の $d\\ge2$。cycle 29 step 2 はここを「反復多項式環の型」と書いたが、" +
      "その壁は step 3b で消えた（周期点数の終結式表示は一般の $d$ で書けた）。" +
      "残っているのは別のことで、簡約周期点数は $P$ が消える組だけを除く量であり、" +
      "その除去は変数ごとに剥がす形にならない。書き方は未着手で、書けるかどうかも確かめていない。",
    partStates: [
      { part: "∞ 素点", state: "残り", why: "多変数の Mahler 測度が mathlib に無く、本論文もこの段は外部定理を引いている" },
      { part: "p 素点, 有限 L", state: "残り", why: "$d=1$ は書いたが $d\\ge2$ が残る（簡約は変数ごとに剥がせない）" },
      { part: "p 素点, 塔の漸近", state: "残り", why: "Monsky と Cuoco–Monsky の適用であり、その 2 件がまだ無い" },
    ],
  },
  {
    block: "paper_052_theorem_l0_computable",
    state: "部分的",
    remaining:
      "cycle 28 で (F1) の心臓部を形式化した（PropFFiniteSupport.lean）。" +
      "すなわち「すべてのファイバーの係数和が消えるなら分類写像は台の上で単射でない」という数え上げの一点と、" +
      "そこから出る「割りうる方向は有限集合 $V(E)=\\{\\mathrm{prim}(e-e'):e\\ne e'\\in E\\}$ に入る」" +
      "という包含である（非可算な $\\mathbb{P}^{d-1}(\\mathbb{Z}_p)$ を走らなくてよいことの中身）。" +
      "残るのは 2 つ。(1) $(\\gamma_v-1)\\mid\\bar f$ と係数和の消滅の同値そのもの。" +
      "これは $d$ 変数の完備群環 $\\mathbb{F}_p[[\\Gamma]]$ とその素イデアルの記述が要るが、" +
      "mathlib には岩澤代数の一般論が `PowerSeries` の断片としてしか無い（配線ではなく素材から要る。" +
      "2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle29-duality.log` の「d 変数の完備群環」の段。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、連結語 `MvPowerSeries.completion` 0 件・" +
      "語幹 `iwasawa algebra` は p 進測度の章の 1 ファイルだけ）。" +
      "(2) (F2 境界) の停止問題への帰着。mathlib に `Nat.Partrec` / `Turing` は在るが、" +
      "「係数を計算する手続きで与えられた $f$」という入力の与え方を型にする設計をこちらが持っていない" +
      "（mathlib の欠落ではなく、こちらの未設計である）。",
    partStates: [
      { part: "F1", state: "残り", why: "心臓部（係数和が消えれば方向は有限集合に入る）は書いたが、同値そのものには $d$ 変数の完備群環が要る" },
      { part: "F2", state: "残り", why: "停止問題への帰着。入力の与え方を型にする設計をこちらが持っていない" },
    ],
  },
  {
    block: "paper_053_theorem_lower_order",
    state: "未着手",
    reason:
      "命題 G の 4 部（低位項・退化点の計数・トーラス塔・消滅深度による一般の退化塔）は、" +
      "いずれも塔の全域木数の漸近に依る。matrix-tree 定理が mathlib に無い" +
      "（cycle 30 step 2 で自前で書くと判断し、入口＝多重グラフの符号付き接続行列と " +
      "$L=D\,D^{\mathsf T}$ を書いた。MultigraphLaplacian.lean。" +
      "**cycle 32 step 1 で Cauchy–Binet が完了したので、残るのは小行列式の $\pm1$ 性・" +
      "Kirchhoff・指標分解の 3 段である**（cycle 31 総括は 2 段と書いていたが実測は 3 段）。" +
      "**小行列式の段は cycle 32 step 3 で半分入った**（全単模性。`IncidenceUnimodular.lean`）。" +
      "`outputs/reports/cycle30_ops_matrix_tree_decision.md` に段取りがある。" +
      "**この主張は matrix-tree だけでは完了しない**——Cuoco–Monsky の岩澤型漸近も要る）。" +
      "不在の根拠は 2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle30-matrixtree.log`" +
      "（mathlib `520045ab14` の 8264 ファイルを 3 段で引き、`matrixTree` / 語幹 `matrix tree` / " +
      "`kirchhoff` / `CauchyBinet` はいずれも 3 段とも 0 件。" +
      "全域木そのものは語幹 `spanning tree` で 3 ファイルに現れるが、" +
      "個数を数える定理の連結語 `numSpanningTrees` は 0 件）。" +
      "**cycle 37 step 2 で、外部定理 Kirchhoff の matrix-tree 定理そのものは完了した**（`SpanningConnectivity.det_submatrix_eq_one_or_neg_one` と `KirchhoffCounting.det_mul_transpose_eq_card_spanning`。根の行を落としたラプラシアンの行列式が全域木の個数に等しいところまで）。**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。**cycle 38 step 2 でその指標分解の芯を書いた**（`CharacterDecomposition.lean` の `det_blockCirculant`。巡回群 $\\mathbb{Z}/N$ の平行移動で不変な行列——ブロック巡回行列——は、指標の行列で共役をとるとブロック対角になり、$\\det M=\\prod_j\\det\\widehat M(j)$ が出る）。**係数環に要るのは「$1$ の原始 $N$ 乗根を持ち $N$ が単元である整域」だけで、$\\mathbb{Z}[\\zeta_N]\\subset\\overline{\\mathbb{Q}}$ で足りる。$\\mathbb{R}$ にも $\\mathbb{C}$ にも出ない。** **cycle 39 step 2 で、cycle 38 が残していた 3 つを書いた**（`CharacterDecompositionTwoVariable.lean`）——(a) $\\Gamma=\\mathbb{Z}/N\\times\\mathbb{Z}/N'$（本文の $\\mathbb{Z}_\\ell^2$ 塔はこちら）の場合は `det_blockCirculant₂`（重ね方は添字の付け替えだけで、巡回の場合を 2 回使えば出る）、(b) 導来グラフのラプラシアンがブロック巡回であることは `derivedLaplacian_eq_blockCirculant`（内容があるのは次数が層に依らないことだけである）、(c) 各層のブロックが voltage ラプラシアンの評価値であることは `hat_eq_evalChar` と `det_hat_eq_evalChar_det`（指標は群環から $R$ への環準同型を与えるので行列式とも交換する）。**したがってこの主張の残りは指標分解ではなくなった。ただし完了はしない。件数は動いていない。そう書く**——この主張はこれとは別の残りを持つ（下記）。**指標分解の側にも残りはあるが、それは本主張の残りではなく道具の一般性の話である**（扱ったのは巡回群 1 つと巡回群 2 つの積までであり、導来グラフの側は辺の本数の核として受け取っている）。",
  },
  {
    block: "paper_055_theorem_theta_infinity",
    state: "部分的",
    remaining:
      "命題 G′ は (G′3) の閉形式と、cycle 26 が形式化した証明の主要 6 ステップまで。" +
      "Newton 多面体・$\\pi$ 進評価・例外直線の決定は未形式化。" +
      "**cycle 33 step 2 の照合で、この欄が `lean/` の記述より少なく書いていたことが分かったので足す**——" +
      "`BouquetClosedForm.lean` は残りとして (a) $\\kappa_n$ の独立計算（matrix-tree 定理。" +
      "$\\ell^{2n}\\times\\ell^{2n}$ 行列式で、mathlib に全域木数の公式が無い。**配線ではなく素材の欠落**。" +
      "2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle30-matrixtree.log`。mathlib `520045ab14` の " +
      "8264 ファイルを 3 段で引き、`matrixTree` / 語幹 `matrix tree` / `kirchhoff` がいずれも 3 段とも 0 件）と " +
      "(b) 定理 X の付値計算そのもの（$v_\\ell(h^N-1)=\\ell^{\\nu(N)}/\\varphi_m$。" +
      "$\\mathbb{Q}(\\zeta_{\\ell^m})$ の $\\ell$ の上の素点への**配線**。円分体も分岐も mathlib に在る）を挙げている。" +
      "`GeneralTowerClosedForm.lean` はさらに 定理 G2 の 1（Galois 不変性。配線）・定理 G2 の 3（配線）・" +
      "$A_{\\mathrm{gen}}$ の $L$ 非依存性・Matrix–Tree 定理を挙げている。" +
      "**cycle 34 step 5 の照合で、この欄が本文の部を全部覆っていないことが分かったので足す**——(G′1) と (G′2) は、この欄が 1 度も触れていなかった。どちらも未形式化である。" +
      "**cycle 37 step 2 で、外部定理 Kirchhoff の matrix-tree 定理そのものは完了した**（`SpanningConnectivity.det_submatrix_eq_one_or_neg_one` と `KirchhoffCounting.det_mul_transpose_eq_card_spanning`。根の行を落としたラプラシアンの行列式が全域木の個数に等しいところまで）。**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。**cycle 38 step 2 でその指標分解の芯を書いた**（`CharacterDecomposition.lean` の `det_blockCirculant`。巡回群 $\\mathbb{Z}/N$ の平行移動で不変な行列——ブロック巡回行列——は、指標の行列で共役をとるとブロック対角になり、$\\det M=\\prod_j\\det\\widehat M(j)$ が出る）。**係数環に要るのは「$1$ の原始 $N$ 乗根を持ち $N$ が単元である整域」だけで、$\\mathbb{Z}[\\zeta_N]\\subset\\overline{\\mathbb{Q}}$ で足りる。$\\mathbb{R}$ にも $\\mathbb{C}$ にも出ない。** **cycle 39 step 2 で、cycle 38 が残していた 3 つを書いた**（`CharacterDecompositionTwoVariable.lean`）——(a) $\\Gamma=\\mathbb{Z}/N\\times\\mathbb{Z}/N'$（本文の $\\mathbb{Z}_\\ell^2$ 塔はこちら）の場合は `det_blockCirculant₂`（重ね方は添字の付け替えだけで、巡回の場合を 2 回使えば出る）、(b) 導来グラフのラプラシアンがブロック巡回であることは `derivedLaplacian_eq_blockCirculant`（内容があるのは次数が層に依らないことだけである）、(c) 各層のブロックが voltage ラプラシアンの評価値であることは `hat_eq_evalChar` と `det_hat_eq_evalChar_det`（指標は群環から $R$ への環準同型を与えるので行列式とも交換する）。**したがってこの主張の残りは指標分解ではなくなった。ただし完了はしない。件数は動いていない。そう書く**——この主張はこれとは別の残りを持つ（下記）。**指標分解の側にも残りはあるが、それは本主張の残りではなく道具の一般性の話である**（扱ったのは巡回群 1 つと巡回群 2 つの積までであり、導来グラフの側は辺の本数の核として受け取っている）。" +
      "**cycle 45 step 1 の全数の数え直しで、この欄が名指ししながら数えていなかった事柄が 4 つ見つかった**——" +
      "上に挙がっている 定理 X の付値計算そのもの・定理 G2 の 1・定理 G2 の 3・$A_{\\mathrm{gen}}$ の $L$ 非依存性 である。" +
      "**いずれも本文の部（(G′1)(G′2)(G′3)）ではないので、部の勘定からは漏れていた。** " +
      "残り項目として数える（Matrix–Tree 定理と指標分解はそれぞれ cycle 37・cycle 39 で閉じたので数えない）。",
    remainingItems: [
      "定理 X の付値計算そのもの",
      "定理 G2 の 1（Galois 不変性",
      "定理 G2 の 3（配線）",
      "$A_{\\mathrm{gen}}$ の $L$ 非依存性",
    ],
    partStates: [
      { part: "G′1", state: "残り", why: "消滅深度が無限大になる軌跡。Newton 多面体の辺方向へ落とす段が未形式化" },
      { part: "G′2", state: "残り", why: "段階的処理による点ごとの付値。未形式化" },
      { part: "G′3", state: "残り", why: "閉形式と場合分けは書いたが、例外直線の決定そのものが未形式化" },
    ],
  },
  {
    block: "paper_056_theorem_ell2_family",
    state: "部分的",
    remaining:
      "命題 G″ は閉形式の形・場合分けの排反と網羅・$n=1$ の但し書き、および cycle 27 が形式化した " +
      "(G″1) の付値の議論まで。4 通りの閉形式の導出そのものは未形式化。" +
      "**cycle 34 step 3 の照合で、`EllTwoClosedForm.lean` が挙げている matrix-tree 定理も足す**" +
      "（$\\kappa_n$ の独立計算に要る。外部定理の台帳を見よ）。" +
      "**cycle 34 step 5 の照合で足す**——本文の (G″2)(G″3)(G″4)(G″5) は、この欄が 1 度も触れていなかった。いずれも未形式化である（形式化してあるのは (G″1) の付値の議論だけである）。" +
      "**cycle 37 step 2 で、外部定理 Kirchhoff の matrix-tree 定理そのものは完了した**（`SpanningConnectivity.det_submatrix_eq_one_or_neg_one` と `KirchhoffCounting.det_mul_transpose_eq_card_spanning`。根の行を落としたラプラシアンの行列式が全域木の個数に等しいところまで）。**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。**cycle 38 step 2 でその指標分解の芯を書いた**（`CharacterDecomposition.lean` の `det_blockCirculant`。巡回群 $\\mathbb{Z}/N$ の平行移動で不変な行列——ブロック巡回行列——は、指標の行列で共役をとるとブロック対角になり、$\\det M=\\prod_j\\det\\widehat M(j)$ が出る）。**係数環に要るのは「$1$ の原始 $N$ 乗根を持ち $N$ が単元である整域」だけで、$\\mathbb{Z}[\\zeta_N]\\subset\\overline{\\mathbb{Q}}$ で足りる。$\\mathbb{R}$ にも $\\mathbb{C}$ にも出ない。** **cycle 39 step 2 で、cycle 38 が残していた 3 つを書いた**（`CharacterDecompositionTwoVariable.lean`）——(a) $\\Gamma=\\mathbb{Z}/N\\times\\mathbb{Z}/N'$（本文の $\\mathbb{Z}_\\ell^2$ 塔はこちら）の場合は `det_blockCirculant₂`（重ね方は添字の付け替えだけで、巡回の場合を 2 回使えば出る）、(b) 導来グラフのラプラシアンがブロック巡回であることは `derivedLaplacian_eq_blockCirculant`（内容があるのは次数が層に依らないことだけである）、(c) 各層のブロックが voltage ラプラシアンの評価値であることは `hat_eq_evalChar` と `det_hat_eq_evalChar_det`（指標は群環から $R$ への環準同型を与えるので行列式とも交換する）。**したがってこの主張の残りは指標分解ではなくなった。ただし完了はしない。件数は動いていない。そう書く**——この主張はこれとは別の残りを持つ（下記）。**指標分解の側にも残りはあるが、それは本主張の残りではなく道具の一般性の話である**（扱ったのは巡回群 1 つと巡回群 2 つの積までであり、導来グラフの側は辺の本数の核として受け取っている）。",
    partStates: [
      { part: "G″1", state: "済み", witness: "EllTwo.ordKappaAalpha" },
      { part: "G″2", state: "残り", why: "閉形式の導出そのものが未形式化" },
      { part: "G″3", state: "残り", why: "閉形式の導出そのものが未形式化" },
      { part: "G″4", state: "残り", why: "閉形式の導出そのものが未形式化" },
      { part: "G″5", state: "残り", why: "閉形式の導出そのものが未形式化" },
    ],
  },
  { block: "paper_061_theorem_V", state: "完了", note: "命題 V は $d=1$ と $d=2$。" },
  {
    block: "paper_062_theorem_T",
    state: "部分的",
    remaining:
      "命題 T は代数的な段と算術の段まで。matrix-tree の段（mathlib に無い。" +
      "2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle30-matrixtree.log`。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、`matrixTree` / `kirchhoff` / `CauchyBinet` が" +
      "いずれも 3 段とも 0 件。cycle 30 step 2 で自前で書くと判断し入口を書いた。" +
      "MultigraphLaplacian.lean。**cycle 32 step 1 で Cauchy–Binet は完了し、" +
      "残るのは小行列式の $\pm1$ 性・Kirchhoff・指標分解の 3 段である。" +
      "うち小行列式の段は cycle 32 step 3 で半分入った**＝全単模性。" +
      "残るのは「$\pm1$ になるのが全域木のときに限る」という組合せの側）と、" +
      "2 の不分岐性・Hensel 持ち上げの段（Hensel は mathlib に在るが円分体の完備化への配線が無い）が残る。" +
      "**残りは 2 つである。**" +
      "**cycle 37 step 2 で、外部定理 Kirchhoff の matrix-tree 定理そのものは完了した**（`SpanningConnectivity.det_submatrix_eq_one_or_neg_one` と `KirchhoffCounting.det_mul_transpose_eq_card_spanning`。根の行を落としたラプラシアンの行列式が全域木の個数に等しいところまで）。**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。**cycle 38 step 2 でその指標分解の芯を書いた**（`CharacterDecomposition.lean` の `det_blockCirculant`。巡回群 $\\mathbb{Z}/N$ の平行移動で不変な行列——ブロック巡回行列——は、指標の行列で共役をとるとブロック対角になり、$\\det M=\\prod_j\\det\\widehat M(j)$ が出る）。**係数環に要るのは「$1$ の原始 $N$ 乗根を持ち $N$ が単元である整域」だけで、$\\mathbb{Z}[\\zeta_N]\\subset\\overline{\\mathbb{Q}}$ で足りる。$\\mathbb{R}$ にも $\\mathbb{C}$ にも出ない。** **cycle 39 step 2 で、cycle 38 が残していた 3 つを書いた**（`CharacterDecompositionTwoVariable.lean`）——(a) $\\Gamma=\\mathbb{Z}/N\\times\\mathbb{Z}/N'$（本文の $\\mathbb{Z}_\\ell^2$ 塔はこちら）の場合は `det_blockCirculant₂`。**重ね方は添字の付け替えだけである**——$V\\times(\\mathbb{Z}/N\\times\\mathbb{Z}/N')$ を $(V\\times\\mathbb{Z}/N')\\times\\mathbb{Z}/N$ と読み替えると外側が頂点集合 $V\\times\\mathbb{Z}/N'$ のブロック巡回行列になり、その各層のブロックが今度は頂点集合 $V$ のブロック巡回行列になるので、巡回の場合を 2 回使えば出る。(b) 導来グラフのラプラシアンがブロック巡回であることは `derivedLaplacian_eq_blockCirculant`。**内容があるのは次数の側だけである**——隣接行列は定義がすでにブロック巡回で、言うべきことは $(u,g)$ の次数が $g$ に依らないことである。(c) 各層のブロックが評価値であることは `hat_eq_evalChar` と `det_hat_eq_evalChar_det`。voltage ラプラシアンを成分が群環 $R[\\mathbb{Z}/N]$ に住む行列として持つと、指標は群環から $R$ への環準同型を与え、その像がちょうど $\\widehat L(j)$ である。**環準同型なので行列式とも交換し、$\\det\\widehat L(j)$ は $\\det L(z)$ の $z=\\zeta^{j}$ での値になる。** **それでもこの主張は完了しない。そう書く**——この主張の残りは指標分解ではなく、2 の不分岐性・Hensel 持ち上げの段である（円分体の完備化への配線が mathlib に無い）。**指標分解の側にも残りはあるが、それは本主張の残りではなく道具の一般性の話である**（一般の有限アーベル群は扱っておらず、基礎グラフを型として持っていない。`CharacterDecomposition.lean` と `CharacterDecompositionTwoVariable.lean` の残り一覧を見よ）。**残りは 1 つである。**" +
      "**cycle 42 step 2 でその段の中身を書いた**（`PropTHenselLift.lean`）。" +
      "**「Hensel は mathlib に在るが円分体の完備化への配線が無い」という記録を、" +
      "定理の名前ではなく機構の名前で引き直した。判定は変わらないが、射程が狭まった。そう書く**——" +
      "この段が要求しているのは円分体の完備化そのものではなく、" +
      "「Hensel 的な局所環で、剰余体が原始 $L$ 乗根を持つこと」だけである。" +
      "書いたのは 3 つで、(1) $L$ 奇なら標数 2 で $X^L-1$ が分離的であること" +
      "（`separable_X_pow_sub_one_of_odd`。これが「2 は $\\mathbb{Q}(\\zeta_L)$ で不分岐」の中身であり、" +
      "`X_pow_sub_one_separable_iff` がそのまま当たる）、" +
      "(2) 剰余体で $\\zeta^{j}\\neq\\zeta^{-j}$ であること" +
      "（`isUnit_sub_inv_pow_of_primitiveRoot`。$L\\nmid 2j$ から出るので、$L$ が奇であることが 2 度目に効く）、" +
      "(3) $w^2-Aw+1$ の根の持ち上げ（`exists_root_quadratic_of_henselian`。" +
      "$f(\\zeta^{j})$ が極大イデアルに入り $f'(\\zeta^{j})$ が単元であることを見て " +
      "`HenselianLocalRing.is_henselian` へ渡すだけで、円分体も完備化も出てこない）。" +
      "**それでもこの主張は完了しない。残ったのは舞台そのものの構成である。そう書く**——" +
      "本ファイルは「Hensel 的な局所環で剰余体が原始 $L$ 乗根を持つ」ことを仮定として型に出しており、" +
      "$\\mathbb{Q}(\\zeta_L)$ の 2 の上の素点での完備化がそれを満たすことは書いていない。" +
      "**2026-08-05 実測**: `HenselianLocalRing` はこの版の mathlib では " +
      "`Mathlib/RingTheory/Henselian.lean` にしか現れず、インスタンスが 1 つも無い。" +
      "数論側の材料（`IsDedekindDomain.HeightOneSpectrum.adicCompletionIntegers`、6 ファイル）と " +
      "`IsAdicComplete.henselianRing` は在るので、素材ではなく配線である。" +
      "**段 4（Newton 多角形）との接続はこの段の内容ではない**——本ファイルが出すのは $r\\equiv\\zeta^{j}$ までで、$v(m_j)=1$ は段 4 の側である（組合せ核は `PropT.lean` に在る）。" +
      "**cycle 43 step 3 でその舞台を構成した**（`HenselianStage.lean`）。" +
      "**着手時の実測で、台帳の記録が 1 つ誤っていたことが分かった。そう書く**——" +
      "「`HenselianLocalRing` のインスタンスが 1 つも無い」と書いていたが、`Field.henselian` が在る" +
      "（`Mathlib/RingTheory/Henselian.lean` 114 行。ただし体は退化した舞台であって、この段が要求するものではない）。" +
      "**1 ファイルにしか現れないという側は正しく、配線であるという判定も当たっていた。** " +
      "無いのは向きである——在るのは `HenselianLocalRing` から `HenselianRing` へ行く向きと " +
      "`IsAdicComplete` から `HenselianRing` へ行く向きだけで、戻る向きが無い。" +
      "**芯は 1 行である**（`henselianLocalRing_of_henselianRing`）——2 つの定義の違いは" +
      "微分の値に単元性を要求する場所が環の中か剰余環の中かだけで、環の単元は剰余環でも単元だからである。" +
      "これで完備な局所環が Hensel 的であること（`henselianLocalRing_of_isAdicComplete`）が出て、" +
      "$\\mathbb{Z}_p$（`henselianLocalRing_padicInt`）と非アルキメデス的局所体の整数環" +
      "（`henselianLocalRing_localField`）に当たる。**cycle 42 step 2 の持ち上げから舞台の仮定を落とせた**" +
      "（`exists_root_quadratic_localField`）。" +
      "**それでもこの主張は完了しない。段数も 1 段のまま、中身が入れ替わった。そう書く**——" +
      "残っているのは、その舞台の剰余体が原始 $L$ 乗根を持つことの同定である" +
      "（本文が言っているのは $\\mathbb{Q}(\\zeta_L)$ の 2 の上での完備化についてであり、" +
      "`PropTHenselLift.lean` の段 1・段 2 は根の側を仮定として受け取ったままである）。" +
      "**cycle 44 step 2 でその根の側を書いた**（`PropTResidueRoot.lean`）。" +
      "**中身は 1 行の恒等式である**——$\\prod_{k=1}^{L-1}(1-\\zeta^{k})=L$ で、" +
      "$L$ が $O$ の単元なら各因子も単元、すなわち極大イデアルに入らないので、" +
      "剰余体で $0<k<L$ の全てで $\\zeta^{k}\\neq1$ になる。" +
      "**恒等式そのものは mathlib に在った**（`IsPrimitiveRoot.prod_one_sub_pow_eq_order`、" +
      "`Mathlib/RingTheory/RootsOfUnity/Lemmas.lean` 33 行。2026-08-05 実測、" +
      "mathlib `520045ab14` の 8264 ファイル）。**無いのは剰余体の側へ渡す段で、" +
      "在るのは代数体の整数環についてのもの**（`IsPrimitiveRoot.idealQuotient_mk`）**だけであり、" +
      "イデアルの絶対ノルムと $n$ が互いに素であることを要求するので局所環の極大イデアルへは当たらない。**" +
      "書いたのは 4 段で、因子の単元性（`isUnit_one_sub_pow`）、剰余体での原始性" +
      "（`isPrimitiveRoot_residue`）、**本文の「$L$ 奇なら 2 は不分岐」の単元性としての言い換え**" +
      "（`isUnit_natCast_of_odd`。剰余体の標数が 2 なら奇数は単元である）、そして " +
      "cycle 42 step 2 の結論から舞台の根の仮定を落とした形" +
      "（`exists_root_congr_pow_of_odd_of_charTwo`）である。" +
      "**それでもこの主張は完了しない。段数も 1 段のまま、中身が入れ替わった。そう書く**——" +
      "残っているのは、本文の $\\mathbb{Q}(\\zeta_L)$ の 2 の上での完備化がこの舞台の形をしていること" +
      "（$\\zeta_L$ を含み、剰余体の標数が 2 であること）の同定である。" +
      "**代数の側は入った。残ったのは数論の側である。**" +
      "**cycle 45 step 3 でその数論の側を測った（2026-08-05 実測。この作業ツリーへ取り込んだ " +
      "mathlib `v4.32.1` を直読した）**——完備化そのもの（`adicCompletion`）も、" +
      "その整数環（`adicCompletionIntegers`）も、それが離散付値環であることも在る。" +
      "**無いのは鎖の途中の 1 本だけで、完備化の整数環が $\\mathfrak m$ 進完備であること" +
      "（`IsAdicComplete`）の宣言が無い。** " +
      "完備なら Hensel 的であること（`IsAdicComplete.henselianRing`）は在るので、" +
      "そこが埋まれば舞台は繋がる。局所体という舞台のクラス（`IsNonarchimedeanLocalField`）は在るが、" +
      "**定義ファイルの外にインスタンスが 1 つも無い**（数体の完備化がその舞台に載ることは述べられていない）。" +
      "**したがってここは配線ではなく素材の側である。** " +
      "**代わりに、舞台の仮定が空でないことを確かめた**（`PropTStageWitness.lean`）——" +
      "4 元体 $\\mathbb{F}_4$ と $L=3$ が仮定を全部満たし、段 3 の結論がその上で実際に使える" +
      "（`exists_root_on_galoisField`）。**ただしこれは退化した舞台である**" +
      "（極大イデアルが $0$ なので合同が等号になる）。**本文が当てているのは混標数の舞台であって、" +
      "これではない。そう書く。** " +
      "**cycle 46 step 3 で測り直した。判断は「自分では書かない」である。書く必要が無いからである。そう書く**" +
      "（2026-08-05 実測）——**mathlib は $\\mathfrak m$ 進完備性を持っている。" +
      "無かったのは 1 つの綴りについてだけだった。** " +
      "Noether 局所環の $\\mathfrak m$ 進完備化（`Mathlib/RingTheory/AdicCompletion/LocalRing.lean` 127 行）、" +
      "完全体上の Witt ベクトル環（`Mathlib/RingTheory/WittVector/Complete.lean` 116 行）、" +
      "非アルキメデス局所体の整数環（`Mathlib/NumberTheory/LocalField/Basic.lean` 176 行）には" +
      "いずれも `IsAdicComplete` のインスタンスが在る。" +
      "無いのは付値による完備化の整数環（`adicCompletionIntegers`）の綴りだけで、" +
      "**cycle 45 の実測そのものは正しく、誤っていたのは「だから素材が無い」という側である。** " +
      "**そこで舞台を混標数で与え直した**（`PropTMixedWitness.lean`）——" +
      "$\\mathbb{F}_4$ 上の Witt ベクトル環 $W(\\mathbb{F}_4)$ は標数 $0$ の離散付値環で、" +
      "剰余体が $\\mathbb{F}_4$（標数 2）、**極大イデアルは $(2)\\neq0$ である**" +
      "（`maximalIdeal_ne_bot`。cycle 45 の舞台との違いはここである）。" +
      "$1$ の原始 3 乗根は Teichmüller 持ち上げで取り、段 3 の結論がその上で実際に使える" +
      "（`exists_root_on_wittVector`）。**これは $\\mathbb{Q}_2$ の不分岐 2 次拡大の整数環であり、" +
      "$L=3$ のとき本文が当てている舞台そのものである。** " +
      "**途中で mathlib の欠落を 1 つ埋めた**——`HenselianRing R I` から局所環のクラス " +
      "`HenselianLocalRing` へ渡す宣言が無い（`HenselianLocalRing` は `Mathlib/RingTheory/Henselian.lean` の外に" +
      "1 度も現れない）。書く量は 2 行である（`henselianLocalRing_of_isAdicComplete`）。" +
      "**それでもこの主張は完了しない。残りは 1 つで、中身が入れ替わった。そう書く**——" +
      "残っているのは 本文の完備化がこの舞台と同型であることの同定 である" +
      "（$\\mathbb{Z}[\\zeta_L]$ の 2 の上の素点での局所化と、その完備化が不分岐であることが要る）。" +
      "**cycle 48 step 2 で測った。段の形そのものが違っていた。そう書く**" +
      "（2026-08-05 実測、`lean/logs/mathlib-gap-survey-cycle48-completion.log`。" +
      "走査 script は `lean/scripts/mathlib-gap-survey-cycle48-completion.sh`。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引いた）。" +
      "**同型は要らない**——本文の段 3 が使うのは「Hensel 的な混標数の局所環で、" +
      "剰余体が原始 $L$ 乗根を持つこと」だけであり、それが Witt ベクトル環と同型であることは" +
      "1 度も使わない。同型を書く道（完備な離散付値環の構造定理）は 3 段とも 0 件で、" +
      "**要らないものが無いという記録になっていた。** " +
      "**要るのは、完備化そのものがその舞台であることである。そう書き直す。** " +
      "**その形で測ると、鎖のうち 2 本は在り、1 本だけが無い**——" +
      "完備化の整数環が離散付値環であることは在り（`IsDiscreteValuationRing` の" +
      "インスタンスが `Mathlib/NumberTheory/NumberField/Completion/FinitePlace.lean` 76 行に在る。" +
      "**cycle 45 が「無いのは $\\mathfrak m$ 進完備性だけ」と書いたのは正しい**）、" +
      "$\\mathfrak m$ 進完備性と位相の完備性を結ぶ橋も在る" +
      "（`IsAdic.isAdicComplete_iff`、`Mathlib/RingTheory/AdicCompletion/Topology.lean` 76 行）。" +
      "**無いのはその橋を渡る手前の 1 本で、付値の位相が $\\mathfrak m$ 進位相であること" +
      "（`IsAdic`）を述べた宣言が 3 段とも 0 件である。** " +
      "迂回路も塞がっている——局所体のクラス `IsNonarchimedeanLocalField` は" +
      "**定義ファイルの外に 1 度も現れず、どの体にもインスタンスが付いていない**" +
      "（数体の完備化がその舞台に載ることは述べられていない）。" +
      "**したがってここは配線ではなく素材の側である。段数は 1 段のままで、中身が入れ替わった。そう書く**——" +
      "残っているのは 付値の位相が $\\mathfrak m$ 進位相であること（完備化の整数環が Hensel 的な舞台であることへ渡る 1 本） である。",
    remainingItems: [
      "付値の位相が $\\mathfrak m$ 進位相であること（完備化の整数環が Hensel 的な舞台であることへ渡る 1 本）",
    ],
  },
  {
    block: "paper_063_theorem_W",
    state: "部分的",
    remaining:
      "命題 W は非退化性の判定（`Decidable`）と $\\nu$ の帰属まで。閉形式本体は " +
      "Cuoco–Monsky の岩澤型漸近に依り、それが mathlib に無い" +
      "（2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle29-duality.log`。" +
      "mathlib `520045ab14` の 8264 ファイルを 3 段で引き、`Monsky` / `CuocoMonsky` はいずれも 3 段とも 0 件。" +
      "語幹 `iwasawa` は 6 ファイルに当たるが、名前に iwasawa を持つファイルは群論の岩澤分解の 1 本だけで、" +
      "岩澤不変量の漸近ではない）。" +
      "**残りは 1 つである。**" +
      "**cycle 47 step 2 で本文の proof を読んで数え直したら、残りは 1 つではなかった。そう書く**" +
      "（`outputs/reports/cycle47_propW_split.md`）。本文の証明は 3 つに分かれており、" +
      "外部定理に依っているのは $\\mu$ の上界方向だけである——" +
      "**残る 2 つは本文自身が「自前で証明した」と書いている事柄なのに、この欄が 1 度も数えていなかった。**" +
      "(1) 積公式の段（本文の $(★_2)$。指標分解と matrix-tree を塔の全域木数へ当てる段）。" +
      "**道具は 2 つとも本プロジェクトの中に在る**（巡回群 2 つの積についての指標分解は " +
      "`CharacterDecompositionTwoVariable.lean`、Kirchhoff の matrix-tree 定理は外部定理として完了済み）。" +
      "無いのはその 2 つを塔の全域木数へ当てて組み立てる段である。" +
      "(2) 付値の評価と総和の段（非退化条件の下で各点の付値を評価して総和する側。" +
      "本文が述べる「非退化ならば $l_0(f)=0$」の含意はこの内側なので別項目にはしない）。" +
      "(3) $\\mu$ の上界方向（Cuoco–Monsky Theorem 1.7。外部定理の台帳で 1 件として数えているので、" +
      "ここでは二重に数えない）。" +
      "**この数え落としは cycle 45 step 1 が塞いだ経路とは別である。そう書く**——" +
      "cycle 45 が塞いだのは台帳の散文が名指ししながら数に入れていない場合で、検査 J がそれを見る。" +
      "今回は**台帳の散文が本文の証明の構成そのものに触れていない**場合であり、" +
      "散文を読むだけでは検出できない（検査 J は緑のままである）。" +
      "**2026-08-05 実測**（mathlib `520045ab14` の 8264 ファイルを 3 段で引いた）——" +
      "voltage グラフの導来グラフ・全域木数の指標分解による積公式・Cuoco–Monsky の $l_0$ は" +
      "いずれも 3 段とも 0 件、円分体の素点での付値だけが在る（`IsDedekindDomain.HeightOneSpectrum.valuation`。2 ファイル）。" +
      "**したがって残りは 3 つである。**",
    remainingItems: [
      "積公式の段",
      "付値の評価と総和の段",
      "$\\mu$ の上界方向",
    ],
  },
  {
    block: "paper_091_theorem_theta_padic",
    state: "部分的",
    remaining:
      "命題 J は (J1)(J1′) の桁定理が完了、(J4) の総和と係数の取り出しが部分的。" +
      "(J2)(J3)(J5)(J6) の各主張と、cycle 27 で形式化した (J1) の代数的な芯の外側が残る。" +
      "**cycle 34 step 3 の照合で、`Cycle24Corrections.lean` が挙げている 系 Q7 の $r=2$ そのもの（2 変数 Laurent 環の一意分解性が要る配線）を、この欄が書いていなかったので足す。**" +
      "**cycle 33 step 2 の照合で、この欄が `lean/` の記述より少なく書いていたことが分かったので足す**——" +
      "`DigitTheorem.lean` は 命題 J2′ の同値（$\\ell$ 奇なら 破れる $\\iff k=2$ 等）を残りに挙げており、" +
      "`TowerTypeCoefficients.lean` は (a) 定理 J7 の主張そのもの" +
      "（$b=\\sum_{P\\in S_\\infty}j^*(P)$。形式冪級数・Hasse 微分・$\\mathbb{Z}_\\ell$ 冪の**配線**が要る。" +
      "`PowerSeries` も二項冪級数も mathlib に在る）と " +
      "(b) $\\Theta_{M'}$ から $M'\\ell^{M'}$ の係数を読み取る段の一般形（$O$ 記法を型にしていない）を挙げている。" +
      "**cycle 45 step 1 の全数の数え直しで、この欄が名指ししながら数えていなかった事柄が 4 つ見つかった**——" +
      "系 Q7 の $r=2$ そのもの・命題 J2′ の同値・定理 J7 の主張そのもの・" +
      "$\\Theta_{M'}$ から $M'\\ell^{M'}$ の係数を読み取る段の一般形 である。" +
      "**いずれも本文の部（(J1)〜(J6)）ではないので、部の勘定からは漏れていた。** 残り項目として数える。" +
      "**cycle 47 step 3 で 命題 J2′ の同値のうち、代数だけで閉じる側を書いた。残り項目は減らない。中身が狭まった。そう書く**" +
      "（`PropJ2PrimePolarization.lean`。宣言 4 件）——$\\ell$ が奇なら" +
      "**閾値で破れることと $\\bar A_2\\not\\equiv0$ であることは同値である**" +
      "（`fails_iff_Abar_two_ne_zero`）。芯は極形式ひとつで、" +
      "$\\binom{n+m}{2}=\\binom n2+\\binom m2+nm$ を台 $S$ 上で足すと" +
      "$\\bar B((a,b),(u,v))=\\bar A_2(a+u,b+v)-\\bar A_2(a,b)-\\bar A_2(u,v)$ になる" +
      "（`Bbar_eq_Abar_two_polarization`。$\\bar A_1\\equiv0$ も $\\ell$ の奇偶も使わない）。" +
      "逆向きは cycle 19 の `Bbar_diag`（$\\bar B(x,x)=2\\bar A_2(x)$）に $2$ の可逆性を当てる。" +
      "**$\\ell=2$ ではこの向きが落ちる——本文が $\\ell=2$ を別扱いしているのはここである。**" +
      "$\\mathbb{R}$ へも $\\overline{\\mathbb{Q}}$ へも出ない（有限体の値と二項係数だけである）。" +
      "**残っているのは $\\bar A_2\\not\\equiv0$ と $k=2$ を結ぶ側と、$\\ell=2$ の側である。" +
      "どちらも本プロジェクトの側の配線であって、mathlib を引く段ではない——" +
      "$\\bar A_m$ を点ごとの値として持っているものを 2 変数多項式として見る段を、まだ書いていない。そう書く。**",
    remainingItems: [
      "系 Q7 の $r=2$ そのもの",
      "命題 J2′ の同値",
      "定理 J7 の主張そのもの",
      "$\\Theta_{M'}$ から $M'\\ell^{M'}$ の係数を読み取る段の一般形",
    ],
    partStates: [
      { part: "J1", state: "済み", witness: "j1_freshman_dream" },
      { part: "J1′", state: "済み", witness: "cexDigit_fails" },
      { part: "J2", state: "残り", why: "未形式化" },
      { part: "J3", state: "残り", why: "未形式化" },
      { part: "J4", state: "残り", why: "総和と係数の取り出しは部分的で、$O$ 記法を型にしていない" },
      { part: "J5", state: "残り", why: "未形式化" },
      { part: "J6", state: "残り", why: "未形式化" },
    ],
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    state: "部分的",
    remaining:
      "命題 K は (K2)(K3)(K6) と、cycle 27 が形式化した (K5) の一意性・$r_0$ の書き換えまで。" +
      "(K1) の対応と (K4) の重複度の主張は未形式化。" +
      "**cycle 34 step 3 の照合で、`SInfinityDecision.lean` が挙げている 3 件を足す**——補題 W2 の (iv)、定理 W4 の主張そのもの、系 W7。" +
      "**cycle 34 step 5 の照合で足す**——本文の (K7) は、この欄が 1 度も触れていなかった。未形式化である。" +
      "**cycle 41 step 2 で (K6) の 証拠なし を解いた。結果は 残り である。そう書く**——" +
      "内容は Cuoco–Monsky の係数そのもので、その外部定理は 未着手 である。" +
      "**cycle 45 step 1 の全数の数え直しで、この欄が名指ししながら数えていなかった事柄が 3 つ見つかった**——" +
      "補題 W2 の (iv)・定理 W4 の主張そのもの・系 W7 である。" +
      "**いずれも本文の部（(K1)〜(K7)）ではないので、部の勘定からは漏れていた。** 残り項目として数える。" +
      "**cycle 47 step 4 で 系 W7 の素材について判断した。判断は「自分で書く」である。そう書く**" +
      "（`LatticeSegmentLength.lean`。宣言 3 件）。理由は 3 つで、" +
      "Newton 多面体の加法性を cycle 39 step 1 で自前に書いた前例があること、" +
      "格子周長が格子点の数え上げであって $\\mathbb{R}$ にも $\\overline{\\mathbb{Q}}$ にも出ないこと、" +
      "系 W7 が本論文自身の主張なので外部定理として引く先が存在しないことである。" +
      "**第 1 段として、格子周長の各辺の長さ（線分の格子長）とその加法性を書いた**——" +
      "格子長は座標差の最大公約数であり（`latticeLength`）、" +
      "原始ベクトル $v$ の $m$ 倍だけ離れた 2 点では $|m|$ になり（`latticeLength_of_smul`）、" +
      "**平行な 2 線分の Minkowski 和の格子長はそれぞれの格子長の和である**" +
      "（`latticeLength_add_of_parallel`）。これが周長の加法性の芯である。" +
      "**測ってみると、この段には素材が要らなかった。そう書く**——" +
      "要ったのは `Int.gcd` と `Nat.gcd_mul_left` だけである" +
      "（**2026-08-05 実測**。mathlib `520045ab14` の 8264 ファイルを 3 段で引き、" +
      "`perimeter` を含む宣言 0 件・`latticeLength` 0 件。cycle 46 step 4 の実測と同じで、変わらない）。" +
      "**それでも 系 W7 は閉じない。残り項目は 3 件のままである。そう書く**——" +
      "残っているのは、凸格子多角形を辺へ分けて格子長を総和する段と、" +
      "$S_\\infty$ の各点が Newton 多面体の辺の方向を与えることから $b\\le\\frac12\\operatorname{per}$ を出す段である。",
    remainingItems: [
      "補題 W2 の (iv)",
      "定理 W4 の主張そのもの",
      "系 W7",
    ],
    partStates: [
      { part: "K1", state: "残り", why: "対応の主張は未形式化" },
      { part: "K2", state: "残り", why: "(iii) ⇒ (iv) は書いたが逆向きが未形式化（`SInfinityDecision.lean` の残り一覧がそう書いている）" },
      { part: "K3", state: "残り", why: "判定が有限に落ちることは書いたが、手続き全体の主張は未形式化" },
      { part: "K4", state: "残り", why: "重複度の主張は未形式化" },
      { part: "K5", state: "済み", witness: "k5_argmin_unique_above" },
      { part: "K6", state: "残り", why: "cycle 41 step 2 で中を見て決めた。内容は Cuoco–Monsky の係数そのもので、その外部定理は 未着手 である。さらに `SInfinityDecision.lean` の散文が、(K3) の手続きだけでは $b$ が決まらず (K4) の重複度計算が要ることを実例（$\ell=3$・$(p,q)=(3,1)$ で $|S_\infty|=1$ なのに $b=2$）で書いている。閉じる宣言を名指せない" },
      { part: "K7", state: "残り", why: "格子周長による上界。Newton 多面体の加法性は完了したが、この不等式そのものは未形式化" },
    ],
  },
  {
    block: "paper_101_theorem_digit_branch",
    state: "完了",
    note:
      "cycle 35 step 1 で残り 4 件を全部書いたので、命題 R は完了である。" +
      "**cycle 34 総括はここを「残りは 1 つだけ」と書いていたが、それは誤りだった**——" +
      "cycle 34 step 1 が書いた「残っているのは 1 つ」という文は、" +
      "同じサイクルの step 3 が同じ欄へ 2 件書き足した時点で古くなっており、" +
      "書き足した側がその文を直さなかった。cycle 35 の着手時の実測で 4 件と分かり、4 件とも書いた。" +
      "内訳は次のとおり。" +
      "(1) **$\\Psi_M$ の各根へ $\\pi$ を送る環準同型の供給**" +
      "（`ResultantValuationR4.lean` の `exists_ringHom_sub_one`）。" +
      "**Galois 群の記述は要らなかった**——効くのは冪基底の普遍性だけで、" +
      "$\\zeta$ の最小多項式の根ひとつごとに $\\zeta\\mapsto\\xi$ の環準同型が 1 つ決まる。" +
      "台帳が素材として挙げていた `IsCyclotomicExtension.autEquivPow` は使っていない" +
      "（その同型を作るときに使われている普遍性の側だけを使う）。" +
      "円分拡大であることも $K/\\mathbb{Q}$ が Galois であることも整数環の理論も使わない。" +
      "(2) **$\\Psi_M$ がモニックであることと分解すること**" +
      "（`monic_psi` / `splits_psi`。段 4c の `psi_eq_prod` が分解そのものを与えていた）。" +
      "併せて段 5 が仮定として受け取っていた「整数の割り切りが反映されること」も供給した" +
      "（`int_dvd_of_algebraMap_dvd`。$\\mathbb{Z}$ が直和因子であることだけを使う）。" +
      "(3)(4) **$\\mathbb{Z}_\\ell$ 指数の $(1+x)^\\gamma$** と **$\\mathrm{sep}$ についての帰納法**" +
      "（`DigitBranchZellExponent.lean`。cycle 34 step 3 の照合が `DigitBranchRecursion.lean` から写した 2 件）。" +
      "**書いてみると 2 件は同じ 1 本の補題に載っていた**——" +
      "$\\mathbb{Z}_\\ell$ の指数に意味を与えているのは $\\ell$ 進の位相でも完備性でも二項冪級数でもなく、" +
      "$(1+x)^{\\ell^t}=1+x^{\\ell^t}$ という 1 本の等式である" +
      "（指数が $\\ell^t$ を法として等しければ次数 $<\\ell^t$ の係数は一致する）。" +
      "そして $\\mathrm{sep}$ はまさに「代表元へ取り替えてよい深さ」なので、" +
      "$\\mathbb{Z}_\\ell$ 指数の族は $\\mathrm{sep}$ の深さまでは $\\mathbb{N}$ 指数の族と同じ多項式を与える。" +
      "台帳が別々の 2 件として挙げていたのは、その繋がりを見ていなかったためである。" +
      "$\\mathrm{sep}$ そのものも取ってあるので (R3) は仮定を置かない形で言えている" +
      "（`exists_sepAt` / `sep` / `exists_coeff_ne_zero_lt_pow_sep`）。",
  },
  {
    block: "paper_106_theorem_drop_assumption",
    state: "完了",
    note:
      "cycle 33 step 1 で残り 2 件（補題 Q4a・補題 Q1′）を書いたので、命題 Q は完了である。" +
      "内訳は 組合せ・数え上げ・最小点の一意性・誤差の組み立て（`DropAssumptionBStar.lean`）、" +
      "補題 Q0（アルキメデス粗上界。`CrudeArchimedeanBound.lean`。" +
      "**本プロジェクトで複素絶対値を使う唯一の箇所**）、" +
      "補題 Q4a（`CyclotomicValuationQ4a.lean`）、補題 Q1′（`PropQLaurentLift.lean`）。" +
      "**完了と呼ぶ射程を明示する**——" +
      "(1) 補題 Q4a は付値 $v_{\\mathfrak l}$ ではなく **$\\pi=\\zeta-1$ の冪との同伴**で書いた。" +
      "$v_{\\mathfrak l}(\\pi)=1$ なので内容は同じだが、**証明が使うのは $\\pi$ の素元性と整域性だけ**で、" +
      "Dedekind 性も類数も一意分解性も使わない（$\\mathcal{O}_K$ は一般には一意分解環でないので " +
      "$a^N\\sim b^N\\Rightarrow a\\sim b$ は使えない。`dvd_prime_pow` で迂回した）。" +
      "(2) `Prime (ζ - 1)` は仮定として受け取り、それが円分体の整数環で成り立つことを " +
      "mathlib の `zeta_sub_one_prime` で名指ししてある（`prime_zeta_sub_one_ofInteger`）。" +
      "(3) 補題 Q1′ の 2 変数 Laurent 環は `AddMonoidAlgebra ℤ (ℤ × ℤ)`（群環 $\\mathbb{Z}[\\mathbb{Z}^2]$）" +
      "で置いた。**新しい型は作っていない。** " +
      "(4) $\\bar{\\tilde E}$ の分解 $(1.2)$ そのもの（cycle 20 の定理 W1・W4）は補題 Q1′ の主張ではないので、" +
      "仮定として型に出してある。**形式化して分かったのは、補題 Q1′ の証明が " +
      "$\\mathbb{F}_\\ell[z^{\\pm},w^{\\pm}]$ の一意分解性を 1 度も使わないこと**である——" +
      "使うのは「単元倍は割り切りを変えない」だけで、一意分解性は $(1.2)$ を作る側の要求である。" +
      "**mathlib の見立ては 1 件外れていた**: cycle 22 のログは補題 Q4a に " +
      "`ramificationIdx`・`inertiaDeg` が要ると読んでいたが、実際には使わずに済んだ。" +
      "代わりに要ったのは `(ζ-1)^{φ(ℓ^j)} ∼ ℓ` の**素数冪版**で、" +
      "mathlib にあるのは素数版（`associated_zeta_sub_one_pow_prime`）だけだったので自分で書いた" +
      "（`associated_sub_one_pow_totient`）。",
  },
  {
    block: "paper_111_theorem_general_closed_form",
    state: "部分的",
    remaining:
      "命題 M は (M1) の規約・(M2) の $\\lambda$・(M3) の $L$ 非依存性・(M5)(M6)、および " +
      "cycle 27 が形式化した $K(P_0)$ の存在と有界性まで。閉形式の導出そのものは未形式化。" +
      "**cycle 34 step 3 の照合で、`Cycle25Corrections.lean` が挙げている 3 件を足す**——定理 G2 の 1（Galois 不変性。配線）、系 Q7 の $r=2$（2 変数 Laurent 環の一意分解性）、および voltage グラフのラプラシアン行列式そのもの（matrix-tree 定理。外部定理の台帳を見よ）。" +
      "**cycle 34 step 5 の照合で足す**——本文の (M4) は、この欄が 1 度も触れていなかった。未形式化である。" +
      "**cycle 37 step 2 で、外部定理 Kirchhoff の matrix-tree 定理そのものは完了した**（`SpanningConnectivity.det_submatrix_eq_one_or_neg_one` と `KirchhoffCounting.det_mul_transpose_eq_card_spanning`。根の行を落としたラプラシアンの行列式が全域木の個数に等しいところまで）。**この主張が matrix-tree を理由に挙げている段のうち、残っているのは指標分解（塔の各レベルへ分ける段）である**——本文は「指標による対角化と Kirchhoff の matrix-tree 定理から」と 2 つを並べて引いており、指標分解は Kirchhoff の定理の内容ではないので、本文の主張の側の残りとして数える。**cycle 38 step 2 でその指標分解の芯を書いた**（`CharacterDecomposition.lean` の `det_blockCirculant`。巡回群 $\\mathbb{Z}/N$ の平行移動で不変な行列——ブロック巡回行列——は、指標の行列で共役をとるとブロック対角になり、$\\det M=\\prod_j\\det\\widehat M(j)$ が出る）。**係数環に要るのは「$1$ の原始 $N$ 乗根を持ち $N$ が単元である整域」だけで、$\\mathbb{Z}[\\zeta_N]\\subset\\overline{\\mathbb{Q}}$ で足りる。$\\mathbb{R}$ にも $\\mathbb{C}$ にも出ない。** **cycle 39 step 2 で、cycle 38 が残していた 3 つを書いた**（`CharacterDecompositionTwoVariable.lean`）——(a) $\\Gamma=\\mathbb{Z}/N\\times\\mathbb{Z}/N'$（本文の $\\mathbb{Z}_\\ell^2$ 塔はこちら）の場合は `det_blockCirculant₂`（重ね方は添字の付け替えだけで、巡回の場合を 2 回使えば出る）、(b) 導来グラフのラプラシアンがブロック巡回であることは `derivedLaplacian_eq_blockCirculant`（内容があるのは次数が層に依らないことだけである）、(c) 各層のブロックが voltage ラプラシアンの評価値であることは `hat_eq_evalChar` と `det_hat_eq_evalChar_det`（指標は群環から $R$ への環準同型を与えるので行列式とも交換する）。**したがってこの主張の残りは指標分解ではなくなった。ただし完了はしない。件数は動いていない。そう書く**——この主張はこれとは別の残りを持つ（下記）。**指標分解の側にも残りはあるが、それは本主張の残りではなく道具の一般性の話である**（扱ったのは巡回群 1 つと巡回群 2 つの積までであり、導来グラフの側は辺の本数の核として受け取っている）。" +
      "**cycle 41 step 2 で (M1)(M5)(M6) の 証拠なし を解いた。3 件のうち 1 件が 済み、2 件が 残り である。そう書く**——" +
      "(M6)（$S_\\infty=\\emptyset$ の場合の 5 係数）は `Cycle24.corollary_G6` が閉じている" +
      "（定理 G1 へ $\\alpha=\\gamma=0$・$\\beta=A_\\mathrm{gen}$ を入れた形が本文の式と一致し、" +
      "$c=\\Theta_L/\\varphi(\\ell^{L})$ は `corollary_G6_c_as_Theta` が与える）。" +
      "(M1) は規約（$v_\\ell(0)=+\\infty$）だけが形式化されており、層のどの点でも段データが同じであることは未形式化である。" +
      "(M5) は条件 2 の根拠（望遠鏡和と境界）だけで、$M^{*}$ の 5 条件をまとめた主張は未形式化である。" +
      "**cycle 45 step 1 の全数の数え直しで、この欄が名指ししながら数えていなかった事柄が 2 つ見つかった**——" +
      "定理 G2 の 1（Galois 不変性）と 系 Q7 の $r=2$ である。" +
      "**どちらも本文の部（(M1)〜(M6)）ではないので、部の勘定からは漏れていた。** " +
      "残り項目として数える（同じ照合が挙げていた voltage グラフのラプラシアン行列式は " +
      "cycle 37・cycle 39 で閉じたので数えない）。",
    remainingItems: [
      "定理 G2 の 1",
      "系 Q7 の $r=2$",
    ],
    partStates: [
      { part: "M1", state: "残り", why: "cycle 41 step 2 で中を見て決めた。形式化されているのは規約（$v_\ell(0)=+\infty$。`Cycle25Corrections.lean`）だけで、(M1) の主張——深さ $k$ の層のどの点でも $(\mathcal{V}_k,\theta^\sharp_k,m^\sharp_k)$ が同じであること（Galois 共役と $\ell$ の上の素点が 1 つであること）——は未形式化である" },
      { part: "M2", state: "済み", witness: "lambda_u_eq_succ_log" },
      { part: "M3", state: "済み", witness: "Agen_level_indep" },
      { part: "M4", state: "残り", why: "未形式化（cycle 34 step 5 の照合で書き落としが見つかった部である）" },
      { part: "M5", state: "残り", why: "cycle 41 step 2 で中を見て決めた。形式化されているのは条件 2 の根拠（望遠鏡和 `sum_totient_Ico` と境界 `layer_b_boundary`。$M\ge r^\sharp+K$ と同値であること）だけで、$M^{*}$ の 5 条件を 1 本にまとめた主張は未形式化である" },
      { part: "M6", state: "済み", witness: "Cycle24.corollary_G6" },
    ],
  },
  {
    block: "paper_112_theorem_coefficient_layers",
    state: "部分的",
    remaining:
      "命題 U は (U1) の $c$・$d$ が (M3)+(M4) から出ること、(U2)(U4)(U6)、および " +
      "cycle 27 が形式化した $\\ell=2$ の 5 係数の突き合わせまで。(U1) の式そのものの導出と " +
      "(U3)(U5) は未形式化。" +
      "**cycle 35 step 4 の照合で、この欄が本文の部を全部覆っていないことが分かったので足す**——" +
      "(U1a)（飽和深度を大きめに取ってもよいこと）は、この欄が 1 度も触れていなかった。未形式化である。" +
      "cycle 34 step 5 の検査がこれを見落としていたのは、部の記号を `[A-Z][0-9]+` の形でしか" +
      "拾っていなかったためで、`U1a` のように後ろに小文字が付く形が素通りしていた。" +
      "**cycle 41 step 2 で (U2)(U4)(U6) の 証拠なし を解いた。3 件とも 残り である。そう書く**——" +
      "(U2) は帳簿上の恒等式だけ、(U4) は $\\ell=2$ の具体値だけ、" +
      "(U6) は切り捨て付値列から段データを出す側だけで、いずれも部を閉じていない。" +
      "**cycle 42 step 4 で、その 6 件の「広げる先が本文のどこまでか」を測り、(U6) を広げた。**"
      + "測った結果、(U6) の残る側はさらに 2 つに割れる——"
      + "(a) 切り捨て付値の安定性（$A'=A+\\ell^{N}\\beta$ なら $\\min(v_\\ell(A'),N)=\\min(v_\\ell(A),N)$）と、"
      + "(b) $\\Phi^{[k]}$ が $\\mathcal{O}_k$ 係数の線形式であることの配線である。"
      + "**書いたのは (a) である**（`TruncatedValuationStability.lean` の `min_emultiplicity_add_eq`。"
      + "場合分けは 2 つだけで、$v(A)<N$ なら和の付値は $v(A)$ に等しく、$v(A)\\ge N$ なら和も $N$ 以上である）。"
      + "**(b) は残る。そう書く**——これは mathlib の欠落ではなく、本論文の $\\Phi^{[k]}$ の定義を "
      + "Lean へ持ち込む配線である。**したがって (U6) はまだ 残り である。件数は動いていない。**",
    partStates: [
      { part: "U1", state: "残り", why: "$c$・$d$ が (M3)+(M4) から出ることは書いたが、式そのものの導出が未形式化" },
      { part: "U1a", state: "残り", why: "飽和深度を大きめに取ってもよいこと。未形式化" },
      { part: "U2", state: "残り", why: "cycle 41 step 2 で中を見て決めた。在るのは `U2_bracket_eq_Tdef`（(M4) の角括弧が $T_\mathrm{def}$ と一致するという帳簿上の恒等式）だけで、(U2) の 3 分岐の主張そのものは未形式化である" },
      { part: "U3", state: "残り", why: "未形式化" },
      { part: "U4", state: "残り", why: "cycle 41 step 2 で中を見て決めた。在るのは $\ell=2$ の具体値（`U4_c_at_ell_two` / `U4_d_at_ell_two` / `U4_p_one_values`）だけで、(U4) の主張そのものは未形式化である" },
      { part: "U5", state: "残り", why: "未形式化" },
      { part: "U6", state: "残り", why: "cycle 41 step 2 で中を見て決めた。`U6_trunc_determines_stage_data` は「切り捨て付値列 $\Rightarrow$ 段データ」の側だけで、`Cycle25Corrections.lean` 自身が、$\tilde E\bmod\ell^{N}$ が切り捨て付値列を決める側は形式化していないと書いている。半分である。cycle 42 step 4 で残る側を測り、切り捨て付値の安定性（`TruncatedValuation.min_emultiplicity_add_eq`）を書いた。残っているのは $\Phi^{[k]}$ の線形性の配線だけである" },
    ],
  },
];

/**
 * **本文が書いている被覆の数値の在り処**。
 *
 * 本文（形式検証の到達点）は「主張 24 件のうち 完了 5・部分的 16・未着手 3」と数で述べている。
 * **形式化が進めばこの数は古くなるが、古くなったことは本文を読まないと分からない。**
 * cycle 27 は「本文に書いた数と台帳の数が一致することは検査していない」を限界として記録し、
 * cycle 28 step 6 でここを塞いだ。
 *
 * 各ロケールについて、**台帳から数えた実測値を入れた文字列が本文に実在すること**を確かめる。
 * 本文を言い換えたときも赤くなる（そのときは、ここの組み立て方を本文に合わせて直す）。
 * 数だけ直して検査を通す道は無い——**数の出どころが台帳だからである。**
 */
export type CoverageNumberSite = {
  readonly locale: string;
  /** 数値を書いているブロックのラベル。 */
  readonly label: string;
  /** 実測値から、本文に実在すべき文字列を組み立てる。 */
  readonly phrases: (counts: {
    readonly total: number;
    readonly done: number;
    readonly partial: number;
    readonly untouched: number;
    /** 外部定理のうち「自分で証明する」に振り分けた件数。 */
    readonly externalOwn: number;
    /** そのうち完了した件数。**cycle 32 step 1 で追加した。** */
    readonly externalOwnDone: number;
  }) => readonly string[];
};

export const COVERAGE_NUMBER_SITES: readonly CoverageNumberSite[] = [
  {
    locale: "ja",
    label: "paper_remark_formalization",
    phrases: ({ total, done, partial, untouched, externalOwn, externalOwnDone }) => [
      `本論文の主張 ${total} 件のうち、内容が形式化されているのは ${done} 件、`,
      `一部が形式化されているのは ${partial} 件、未着手が ${untouched} 件である。`,
      `自分で証明することにした外部定理は ${externalOwn} 件であり、`,
      `そのうち証明を書き終えたのは ${externalOwnDone} 件である。`,
    ],
  },
  {
    locale: "en",
    label: "paper_remark_formalization",
    phrases: ({ total, done, partial, untouched, externalOwn, externalOwnDone }) => [
      `Of the ${total} assertions of this paper, ${done} have their content `,
      `formalised, ${partial} are formalised in part, and ${untouched} have not been started.`,
      `we have undertaken to prove ${externalOwn} of the external theorems ourselves; `,
      `the number of those proofs that are complete is ${externalOwnDone}.`,
    ],
  },
];

/* ------------------------------------------------------------------------- *
 * 台帳が本文の部を全部覆っているか（cycle 34 step 5）
 * ------------------------------------------------------------------------- */

/**
 * **`部分的` の欄が、その主張の部を 1 つ残らず扱っているかを見る。**
 *
 * cycle 34 の着手時の実測で、**命題 R の欄が (R4) しか書いておらず (R5) を落としていた**
 * ことが分かった。本文の命題 R は (R1)–(R5) の 5 部からなる。
 * 同じ形の書き落としは他にもありうるので、機械が見る。
 *
 * ## 規則
 *
 * 本文の `statement` に `(R1 …` のような**部の見出し**が現れるとき、
 * **`部分的` の欄はその部の記号を 1 つ残らず含んでいなければならない。**
 * `部分的` は「一部だけ形式化した」という意味なので、
 * **どの部がどちら側なのかを書かない限り、その主張は情報を持たない。**
 *
 * `完了` と `未着手` は対象外である——前者は部ごとに書く必要が無く、
 * 後者は「なぜ手が付いていないか」を書く欄であって部の一覧ではないからである。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **部の記号が欄に在ることは確かめられるが、そこに書いてある状態が正しいかは確かめられない。**
 *   （検査 F の他の部分と同じ限界である。）
 * - 部の見出しを持たない主張は対象外なので、そこは人の読みのままである。
 */
export function partLabelsInStatement(statementText: string): string[] {
  // 形 1（cycle 34 step 5）: 地の文の途中に現れる `(R1 …` のような英数字の部の記号。
  const inline = [...statementText.matchAll(/\(([A-Z]′?″?[0-9]+[′″]?)\s/g)].map((m) => m[1]!);
  // 形 2（cycle 35 step 4）: 段落の先頭に置かれた括弧つきの見出し。
  // **形 1 だけでは、英数字の記号を使わない部が素通りしていた**——実測すると
  // 双対命題 D が「(∞ 素点)」「(p 素点, 有限 L)」「(p 素点, 塔の漸近)」で部を切っており、
  // 部を持つ主張 11 件のうちこの 1 件だけが検査の外にいた。
  // 目印は原理からではなく実測から決めた（本文の全 theorem / claim を走査し、
  // 段落の先頭にある括弧つきの見出し 11 件がすべて実際に部の見出しであることを確かめた）。
  const leading = [...statementText.matchAll(/(?:^|\n)\s*\(([^)\n]{1,28})\)?/g)].map((m) => {
    const inner = m[1]!.trim();
    // 英数字の記号で始まるものは、その記号だけを部の名前とする（形 1 と同じ粒度に揃える）。
    const head = inner.split(/\s/)[0]!;
    // 末尾に小文字が付く枝番（`U1a`）も記号として扱う。
    // **cycle 34 step 5 の形はここを見ておらず、`U1a` が素通りしていた。**
    return /^[A-Z]′?″?[0-9]+[a-z]?[′″]?$/.test(head) ? head : inner;
  });
  return [...new Set([...inline, ...leading])];
}

/** 判定。IO を持たないので検出テストからそのまま呼べる。 */
export function auditPartCoverage(input: {
  readonly entries: readonly {
    readonly block: string;
    readonly state: CoverageState;
    readonly text: string;
    readonly statementText: string;
  }[];
}): { violations: string[]; checked: number; parts: number } {
  const violations: string[] = [];
  let checked = 0;
  let parts = 0;
  for (const entry of input.entries) {
    if (entry.state !== "部分的") continue;
    const labels = partLabelsInStatement(entry.statementText);
    if (labels.length === 0) continue;
    checked += 1;
    parts += labels.length;
    const missing = labels.filter((label) => !entry.text.includes(label));
    if (missing.length > 0) {
      violations.push(
        `[台帳が本文の部を覆っていない] ${entry.block} — ` +
          `${missing.join("・")} に 1 度も触れていない（cycle 34 の実測はこの形で (R5) の落ちを見つけた）`,
      );
    }
  }
  return { violations, checked, parts };
}

/**
 * **部の見出しを持たない `部分的` の主張への手当て**（cycle 36 step 5）。
 *
 * 部が無い主張には `auditPartCoverage` を当てられない（実測 6 件）。
 * そこで**欄の側に構造を持たせ**、次の 3 つを見る。
 *
 * 1. 部を持たない `部分的` の欄は、残っている項目の一覧（`remainingItems`）を持つこと。
 * 2. 各項目の文字列が散文にそのまま在ること（片方だけ書き換えたら赤くなる）。
 * 3. 散文が「残るのは N つ」のように**数で要約している**こと。そしてその N が項目数と一致すること
 *    （**書き足して数が変われば赤くなる**）。
 *    **cycle 37 step 5 で「要約していること」そのものを要求に変えた**——
 *    cycle 36 の形では、要約が無い欄で 3 が空振りしていた（実測 6 件中 4 件）。
 *    **空振りする検査は、緑であることが何も意味しない。**
 *
 * 3 が cycle 35・36 で 4 件見つかった事故（書き足したのに要約を直していない）の、
 * 散文の中の列挙にあたる側への手当てである。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **一覧が実態を尽くしているかは確かめられない。** 項目を 1 つ書けば通る。
 *   （書き落としを見つけるのは、これまでどおり着手時の実測である。）
 * - **項目の文言が正しいかも確かめられない**（散文に在ることだけを見る）。
 */
/**
 * **部ごとの状態の判定**（cycle 40 step 2。IO を持たないので検出テストからそのまま呼べる）。
 *
 * 見るのは 2 つ。
 *
 * 1. 宣言した部の集合が、本文から読み取った部の集合と**過不足なく一致する**こと。
 * 2. `済み` と書いた部が、**実在する Lean の宣言を名指している**こと。
 *
 * `残り` と `証拠なし` は、実在しない宣言を名指せないので機械では支えられない。
 * **塞げるのは「済み」と言う側だけである。そう書く。**
 */
export function auditPartStates(input: {
  readonly entries: readonly {
    readonly block: string;
    readonly state: CoverageState;
    readonly statementText: string;
    readonly partStates?: readonly { part: string; state: string; witness?: string }[];
  }[];
  /** `lean/` に実在する宣言の名前（短縮形・完全修飾形のどちらでも当たるようにして渡す）。 */
  readonly declared: ReadonlySet<string>;
}): { violations: string[]; entries: number; parts: number; done: number; unwitnessed: number } {
  const violations: string[] = [];
  let entries = 0;
  let parts = 0;
  let done = 0;
  let unwitnessed = 0;
  for (const entry of input.entries) {
    if (entry.partStates === undefined) continue;
    entries += 1;
    const labels = new Set(partLabelsInStatement(entry.statementText));
    const declaredParts = new Set(entry.partStates.map((p) => p.part));
    for (const label of labels) {
      if (!declaredParts.has(label)) {
        violations.push(
          `[部の状態が宣言されていない] ${entry.block} — ${label} の済み・残りが台帳に無い`,
        );
      }
    }
    for (const part of declaredParts) {
      if (!labels.has(part)) {
        violations.push(
          `[本文に無い部を宣言している] ${entry.block} — ${part} は本文の部ではない（改名で浮いた）`,
        );
      }
    }
    for (const state of entry.partStates) {
      parts += 1;
      if (state.state === "済み") {
        done += 1;
        const witness = state.witness ?? "";
        const short = witness.replace(/^IntegrableLattice\./, "");
        const bare = witness.split(".").pop() ?? witness;
        if (
          !input.declared.has(witness) &&
          !input.declared.has(short) &&
          !input.declared.has(bare)
        ) {
          violations.push(
            `[済みの証拠が lean/ に無い] ${entry.block} — ${state.part} が名指す ${witness} が実在しない`,
          );
        }
      } else if (state.state === "証拠なし") {
        unwitnessed += 1;
      }
    }
  }
  return { violations, entries, parts, done, unwitnessed };
}

export function auditPartlessRemaining(input: {
  readonly entries: readonly {
    readonly block: string;
    readonly state: CoverageState;
    readonly text: string;
    readonly hasParts: boolean;
    readonly remainingItems?: readonly string[];
  }[];
}): { violations: string[]; checked: number; items: number; summarised: number } {
  const violations: string[] = [];
  let checked = 0;
  let items = 0;
  let summarised = 0;
  for (const entry of input.entries) {
    if (entry.state !== "部分的" || entry.hasParts) continue;
    checked += 1;
    const list = entry.remainingItems ?? [];
    if (list.length === 0) {
      violations.push(
        `[部を持たない 部分的 の欄が残りの一覧を持たない] ${entry.block} — ` +
          "本文に部の構造が無いので部の覆いを当てられない。remainingItems に残っている項目を挙げること",
      );
      continue;
    }
    items += list.length;
    for (const item of list) {
      if (!entry.text.includes(item)) {
        violations.push(
          `[残りの一覧が散文と食い違う] ${entry.block} — 「${item}」が欄の散文に無い`,
        );
      }
    }
    // 数で要約しているなら、その数が一覧の件数と一致すること。
    // **過去の要約を引用している文があるので、どれか 1 つが一致すればよい**とする——
    // 「かつて 1 件と書いていた」という記録まで違反にすると、経緯を残せなくなる。
    // 書き足して件数が変われば、一致する要約が 1 つも無くなるので赤くなる。
    const matches = [
      ...entry.text.matchAll(/残(?:るの|り|っているの)は\s*([0-9]+)\s*(?:つ|件|段)/g),
    ];
    if (matches.length === 0) {
      // **cycle 37 step 4 の測定で分かったこと**——要約が無い欄では 3 が空振りする。
      // 実測では 6 件のうち 4 件（cycle 36 時点）がそれだった。
      // **空振りする検査は、緑であることが何も意味しない。** そこで要約そのものを要求する。
      violations.push(
        `[いまの件数を述べる要約が無い] ${entry.block} — ` +
          "部を持たない 部分的 の欄は、いまの残りの件数を散文でも述べること" +
          "（述べていないと、書き足したときに数が古くなる事故を機械が見られない）",
      );
      continue;
    }
    {
      summarised += 1;
      const agrees = matches.some((m) => Number(m[1]) === list.length);
      if (!agrees) {
        violations.push(
          `[要約の数が一覧の件数と合わない] ${entry.block} — ` +
            `散文の要約は ${matches.map((m) => m[0]).join(" / ")} だが一覧は ${list.length} 件。` +
            "欄を書き足したなら、いまの件数を述べる要約も同じコミットで書くこと",
        );
      }
    }
  }
  return { violations, checked, items, summarised };
}
