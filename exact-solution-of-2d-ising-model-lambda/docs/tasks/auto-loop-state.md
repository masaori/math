# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-16 の tick 305 は、「共通分母の正整数倍は共通分母である」を本文・SageMath・Lean（具体版・
  必要十分版・導出版）まで完成させた。** $N$ が $\lambda\in\Lambda_{\mathbb Q}$ の共通分母（証人 $\lambda_N$）で
  $k\ge1$ なら $kN$ も共通分母で証人は $k\lambda_N$（三段の鎖）、したがって二元 $\lambda,\mu$ には共通の共通分母
  $N_\lambda N_\mu$ がある（`claim_common_common_denominator_exists`）ことを示した。レビューでは前 tick の共通分母の
  存在の四層が一致し、本文末尾「この先に書くこと」の済んだ項目を消して先に push した。次は「有理係数の対数順序群の
  順序の定義」。

- **2026-08-16 の tick 304 は、「有理係数の対数順序群の元の共通分母の存在」を本文・SageMath・Lean（具体版・
  必要十分版・導出版）まで完成させた。** $\lambda\in\Lambda_{\mathbb Q}$ の非零値の既約分母の積
  $N_\lambda$ が $1$ 以上で $\lambda$ の共通分母になること、証人が各素数で $(N_\lambda/\operatorname{den})\cdot
  \operatorname{num}$（台の外は $0$）であることを、$p\in S_\lambda$ の七段の鎖と $p\notin S_\lambda$ の五段の鎖で示した。
  レビューでは前 tick の共通分母の定義と独立性の四層が一致し、`def_rational_log_order_group` 末尾の順序の予告
  （「次の定義で正の有理数の比較から」）を「共通分母を通して $\Lambda$ の順序から」へ直して先に push した。
  順序の定義が二元の共通の共通分母を要るので「共通分母の正整数倍は共通分母である」を次のセクションとして足した。

- **2026-08-16 の tick 303 は、「有理係数の対数順序群の順序の定義と共通分母からの独立性」を
  「共通分母の定義と順序判定の共通分母からの独立性」「共通分母の存在」「順序の定義」へ割り、先頭を
  本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。** $N$ が $\lambda\in\Lambda_{\mathbb Q}$ の
  共通分母であるとは $\lambda_N\in\Lambda$ で $N\cdot\lambda=\iota(\lambda_N)$ となるものが在ることと定め
  （一意性は $\iota$ の単射性）、$N,N'$ がともに $\lambda,\mu$ の共通分母なら $\lambda_N\le_\Lambda\mu_N
  \iff\lambda_{N'}\le_\Lambda\mu_{N'}$ を、$N'\lambda_N=N\lambda_{N'}$（七段の鎖と単射性）と順序の
  正整数倍不変性で示した。レビューでは前 tick の正整数倍不変性の四層が一致し、本文末尾「この先に書くこと」に
  残っていた済みの「加法単調性」を消して先に push した。次は「有理係数の対数順序群の元の共通分母の存在」。

- **2026-08-15 の tick 302 は、「有理係数の対数順序群の順序の定義と共通分母からの独立性」から
  前提となる「対数順序群の順序は正整数倍で変わらない」を割り出し、本文・SageMath・Lean（具体版・
  必要十分版・導出版）まで完成させた。** 補助等式 $\operatorname{rat}_{\Lambda}(N\lambda)
  =(\operatorname{rat}_{\Lambda}(\lambda))^{N}$ を帰納法で示し、$\lambda\le_\Lambda\mu\iff
  N\lambda\le_\Lambda N\mu$ を正の有理数上の $N$ 乗の狭義単調性へ落とした。レビューでは前 tick の
  加法単調性の四層を突き合わせて修正無し。次は「有理係数の対数順序群の順序の定義と共通分母からの独立性」。

- **2026-08-15 の tick 301 は、「対数順序群の順序の加法単調性」を本文・SageMath・Lean（具体版・
  必要十分版・導出版）まで完成させた。** まず対数の加法性と正の有理数上での単射性から
  $\operatorname{rat}_{\Lambda}(\lambda+\nu)=\operatorname{rat}_{\Lambda}(\lambda)
  \operatorname{rat}_{\Lambda}(\nu)$ を示し、正の有理数を右から掛ける単調性へ落とした。
  レビューでは前 tick の順序定義と四つの順序律の四層を突き合わせて修正無し。
  次は「有理係数の対数順序群の順序の定義と共通分母からの独立性」。

（これより古い 258 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## セクション台帳

**済んだ範囲**（章ごとの件数。個々の内訳は [auto-loop-archive.md](auto-loop-archive.md) と
MEMORY.md にある。番号で呼ばないので、ここでは章と件数だけを持つ）。

- 固有値の代数性: 128 セクション
- Fisher 零点: 44 セクション
- 分配多項式: 4 セクション
- 転送行列: 4 セクション
- 有限系の自由エントロピー: 10 セクション
- 形式検証の土台: 1 セクション
- 零点の詰め寄り: 5 セクション
- 熱力学極限: 31 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 有理係数の対数順序群の順序の定義 | todo | $\lambda\le\mu:\iff$ 共通の共通分母 $N$ で $\lambda_N\le_\Lambda\mu_N$。存在（`claim_common_common_denominator_exists`）と `claim_common_denominator_order_independent`（済）で well-defined。判定は有理数の比較で決定可能 |
| 熱力学極限 | 有理係数の対数順序群の順序の線形順序性と加法単調性 | todo | 三分律・推移律・加法単調性を、共通分母を揃えて $\Lambda$ の順序へ落として示す。決定可能性も述べる |
| 熱力学極限 | 有限系の実自由エントロピーを畳む | todo | $\varphi_L$（ℝ 値）と $\Phi_L$（$\Lambda$ 値）の二重持ちを解消し、有限系の主張・接合不等式・上下界を $\Phi_L$ 側へ寄せる |
| 熱力学極限 | 極限の存在を $\Lambda\otimes\mathbb{Q}$ の Cauchy 性として述べる | todo | 完備性（上限の存在）を使わずに、可算側の主張として収束の速さつきで述べる。各段の比較は有理数の比較なので決定可能 |
| 熱力学極限 | 切断による ℝ への一度きりの脱出 | todo | 「この有理数の列が定める切断として実数が存在する」だけを引く。章頭の「実数体への脱出の宣言」をここへ移し、完備性の宣言は不要になれば畳む |
| 熱力学極限 | 旧実数値経路を撤去する | todo | 可算側の密度・Cauchy 性・切断からの実数化が揃ったあと、$\varphi_L$ と実数値の上下限・上限／下限による極限経路、および対応する SageMath・Lean を削除し、参照と台帳を新経路へ揃える |
| 熱力学極限 | 開境界正方形と部分正方形の値の比較（$1\le t$ の場合） | todo | $1\le a<L$、$c=L-a$ に対し、接合不等式の $1\le t$ 側と値の下界 $1$・配位数による上界 $2^{ab}t^{2ab}$ で挟む。予定: $Z_{a,a}\le Z_{L,L}\le2^{L^2-a^2}t^{a+L+2(L^2-a^2)}Z_{a,a}$（$0<t\le1$ 側は済。Lean は `split_twice_bounds_necSuf` と同型の必要十分版で書ける見込み） |
| 熱力学極限 | 部分正方形との比較の対数化 | todo | $\psi^{\mathrm{op}}_L(t)$ を $\iota(a^2/L^2)\psi^{\mathrm{op}}_a(t)$ と $\log_{\mathbb R}t$・$\log_{\mathbb R}2$ の有理数倍で二場合に挟む |
| 熱力学極限 | 開境界密度の極限（$0<t\le1$ の場合） | todo | 任意近接の $a$ を固定し、$ka\le L<(k+1)a$ で $\psi^{\mathrm{op}}_L$ を $\psi^{\mathrm{op}}_{ka}$ で挟んで、下限 $v$ への $\varepsilon$–$N$ の言明を閉じる |
| 熱力学極限 | 開境界密度の極限（$1\le t$ の場合） | todo | 同じ論法で上限 $u$ への収束を閉じる |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-16（tick 305）: `claim_common_denominator_multiple` と `claim_common_common_denominator_exists` を
  `claim_common_denominator_exists` の直後に置き四層で閉じた。前者は $(kN)\cdot\lambda=k\cdot(N\cdot\lambda)
  =k\cdot\iota(\lambda_N)=\iota(k\lambda_N)$ の三段、後者は前者を $k=N_\mu$・$k=N_\lambda$ で二度使い $\mathbb N$ の
  積の可換性で閉じる。SageMath `common-denominator-multiple` は素数 $2,3,5$・係数 8 種の 512 ベクトルで $N\le12$ の
  共通分母と $k\le4$ の組 8836 件（鎖の各段と一意性）、二元 262144 組を `ZZ`/`QQ` で厳密に。Lean 具体版
  `ThermodynamicLimit/CommonDenominatorMultiple.lean`（`commonDenominator_mul`、`commonCommonDenominator_exists`）、
  必要十分版 `multiple_clears_necSuf`（倍の結合則、積を保つ写像、倍と $\iota$ の交換だけ。有理数・整数・有限台は
  本質でない）、導出版。sorry 検査 1114 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 304）: `claim_common_denominator_exists` を `def_common_denominator` の直後に置き四層で閉じた。
  有理数の既約分数表示 $\operatorname{num}/\operatorname{den}$ と、$N_\lambda:=\prod_{p\in S_\lambda}\operatorname{den}(\lambda(p))$
  （空積 $1$）を導入し、証人 $\nu(p)=(N_\lambda/\operatorname{den})\cdot\operatorname{num}$ で $N_\lambda\cdot\lambda=\iota(\nu)$ を
  各素数で示した。SageMath `common-denominator-exists` は素数 $2,3,5,7$・係数 10 種の 10000 ベクトル（零写像を含む）で
  鎖の各段と等式を `ZZ`/`QQ` で厳密に。Lean 具体版 `ThermodynamicLimit/CommonDenominatorExists.lean`
  （`denominatorProduct`、`denominatorProduct_pos`、`den_dvd_denominatorProduct`、`commonDenominatorWitness`、
  `commonDenominator_exists`。`Nat.div_mul_cancel`・`Rat.mul_den_eq_num`）、必要十分版 `denominator_product_clears_necSuf`
  （可換半環の値、有限集合の外で $0$、各点の分母・分子の等式、$\mathbb N$ 倍を保つ写像だけ。有理数・素数・既約性は本質でない）、
  導出版。sorry 検査 1110 件。**割り直し**: 順序の定義が二元の共通の共通分母を要るので、「共通分母の正整数倍は
  共通分母である」（一つの短い鎖）を順序の定義の前に足した。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 303）: **割り直し**: 「有理係数の対数順序群の順序の定義と共通分母からの独立性」は、
  共通分母の定義と独立性（$\iota$ の単射性と正整数倍不変性）、共通分母の存在（分母の積）、順序の定義の
  三つの論法を含むので三つへ割り、先頭を閉じた。`def_common_denominator`（一意性つき）と
  `claim_common_denominator_order_independent` を章「熱力学極限」の分母消去の直後に置いた。SageMath
  `common-denominator-order-independent` は係数 7 種・素数 3 つの 343 ベクトル、$N,N'\le12$ で証人 1786 件・
  交差等式と同値 2082724 件を `ZZ`/`QQ` で厳密に。Lean 具体版 `ThermodynamicLimit/CommonDenominator.lean`
  （`IsCommonDenominator`、`commonDenominator_unique`、`commonDenominator_cross_smul`、
  `commonDenominator_order_independent`）、必要十分版 `cross_multiple_order_independent_necSuf`（単射で倍を保つ写像、
  倍の可換性、順序の倍不変性だけ）、導出版。sorry 検査 1105 件。式変形統一は一時停止中のため実施せず。

- 2026-08-15（tick 302）: **割り直し**: 「有理係数の対数順序群の順序の定義と共通分母からの独立性」の
  備考が使う「$\Lambda$ の順序の正整数倍不変性」は本文に無く、それ自体が一つの論法（冪への移送と
  $N$ 乗の単調性）なので、先に `claim_log_order_group_positive_multiple_invariant` として章
  「有限系の自由エントロピー」の加法単調性の直後に置き四層で閉じた。SageMath
  `log-order-group-positive-multiple-invariant` は 125 ベクトル・$N\le4$ で冪等式 625 件と同値 62500 件を
  `ZZ`/`QQ` で厳密に。Lean 具体版 `FreeEntropy/LogOrderGroupPositiveMultipleInvariant.lean`
  （`rationalOfLog_natSmul`、`logOrderLE_natSmul_iff`）、必要十分版 `pullback_multiple_iff_necSuf`
  （倍を冪へ送る写像と、冪が像の上で順序を保ちかつ反映することだけ）、導出版。sorry 検査 1100 件。
  式変形統一は一時停止中のため実施せず。

- 2026-08-15（tick 301）: `claim_rational_of_log_additive` と
  `claim_log_order_group_add_monotone` を四層で閉じた。SageMath は素数三つ・係数五つの
  125 ベクトルについて加法対 15625 件と単調性三つ組 984375 件を `ZZ`/`QQ` で厳密に検査した。
  Lean 具体版は対数の加法性・単射性と有理数の乗法単調性を本文と同じ順で辿り、必要十分版は
  逆写像・積を和へ送る性質・正の範囲での単射性、および和を積へ送る写像と右乗法の単調性だけを残した。

（これより古い 270 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録

- 2026-08-16（tick 305）: 前 tick の「有理係数の対数順序群の元は共通分母を持つ」の本文・SageMath・Lean 具体版・
  必要十分版・導出版を突き合わせ、七段・五段の鎖・対象ラベル・入口 import・sorry 検査への登録が一致した。
  既約分数表示 $\operatorname{num}/\operatorname{den}$ は本文で初出であり、対数の定義の $a/b$ 表示と衝突しない。
  本文末尾「この先に書くこと」に済んだ「共通分母の存在」が残っていたので消し、「共通分母の正整数倍が共通分母で
  あること」へ揃えた。

- 2026-08-16（tick 304）: 前 tick の「共通分母の定義と順序判定の共通分母独立性」の本文・SageMath・Lean 具体版・
  必要十分版・導出版を突き合わせ、七段の鎖・同値の鎖・対象ラベル・入口 import・sorry 検査への登録が一致した。
  `def_rational_log_order_group` 末尾の「順序は次の定義で正の有理数の比較から移す」が現在の構成（共通分母を通して
  $\Lambda$ の順序から移す）と食い違っていたので、その旨へ書き直した。

- 2026-08-16（tick 303）: 前 tick の「対数順序群の順序は正整数倍で変わらない」の本文・SageMath・Lean 具体版・
  必要十分版・導出版を突き合わせ、補助等式の帰納法、同値の鎖、対象ラベル、入口 import、sorry 検査への登録が
  一致した。本文末尾「この先に書くこと」に済んだ「対数順序群の順序の加法単調性」が残っていたので消し、
  残りの列挙を共通分母・順序の定義へ揃えた。

- 2026-08-15（tick 302）: 前 tick の「対数順序群の順序の加法単調性」の本文・SageMath・Lean 具体版・
  必要十分版・導出版を突き合わせた。和を積へ移す補助主張、右乗法の単調性、対象ラベル、入口 import、
  sorry 検査への登録が一致しているため修正は無い。

- 2026-08-15（tick 301）: 前 tick の「対数順序群の順序」の本文・SageMath・Lean 具体版・
  必要十分版・導出版を突き合わせた。四つの順序律、反対称律でだけ逆写像を使う段、対象ラベル、
  入口 import、sorry 検査への登録が一致しているため修正は無い。

（これより古い 290 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## 判断待ち（人間に問うべき論点）

- **content のファイルを分けるときの文書順の決め方。** システムは `content/` のファイル名昇順を
  文書順とみなすが、リポジトリの規約はファイル名の連番を禁じている。
  2026-08-08（tick 5）に 2 つめの章を書くときこれに当たった。連番は振らず、章ごとにファイルを
  分けることもせず、**本文を 1 ファイル `content/main-text.ts` へまとめて章を見出しブロックで
  区切る**形にした（ファイルが 1 つなら配列順がそのまま文書順になり、論点に当たらないため。
  旧ファイル名 `partition-polynomial.ts` は 1 章分しか指さないので改名した）。
  これは論点の解決ではなく回避である。本文が育ってファイルを分けたくなった時点で決着が要る。
  → **決着の案（人間の判断を待つ）**: システム側（リポジトリ直下 `structured-latex/`）に
  文書順の明示的な宣言（例えば `content/order.ts` にファイル名を並べる）を入れ、
  ファイル名昇順という暗黙の規則をやめる。この変更はシステム側の入力言語に触るため、
  他プロジェクト（`exact-solution-of-2d-ising-model/` 等）にも影響する。

## cron（launchd）

- ラベル: `com.masaori.ising-lambda-auto-loop`
- 定義: `~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`
- 実体: `scripts/auto-loop-tick.sh`（毎時 5 分、見送られたときの再試行が 35 分。45 分で打ち切る）
- ログ: `logs/auto-loop.log`（git 管理外）
- 各 tick は**独立した新しいセッション**として走る（文脈を持ち越さない。持ち越すのは
  この台帳とリポジトリの中身だけ）。使うエージェントは **Claude と Codex の交互**
  （Claude は `claude-fable-5` の effort medium、Codex は `gpt-5.6-sol` の reasoning medium）。
  片方が使用量の上限に当たった間は、期限を `logs/claude-blocked-until` へ記録してもう片方だけで回す。
- 監査は別ジョブ（毎時 55 分の軽い監査 `scripts/audit-light.sh`、毎日 04:20 の重い監査
  `scripts/audit-loop.sh`）。PDF は `scripts/refresh-pdf.sh` が 5 分おきに最新へ保つ。

停止するには `launchctl bootout gui/$(id -u)/com.masaori.ising-lambda-auto-loop`。
再開するには `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`。
