# Lean の通しの証明と章立てへの組み直し Runbook

## ゴールライン

2026-10-31 の代表の指示（「Lean の構成も直して。通しで証明できていないなら意味がない」）による。次がすべて成り立てば完了である。

- **厳密解が、具体的な分配関数から閉形式まで、結合定数の正値性以外の仮定なしで Lean で証明されている。**
  判定は `lean/scripts/check-end-to-end.sh` が通ることだけで行う。主張の型はこのスクリプトが固定しており、
  Lean 側の定理 `Ising2D.onsager_exact_solution_end_to_end` がその型をそのまま持ち、`sorryAx` に依存しないことを確かめる。
  **スクリプトの主張を弱めて通してはならない。** 主張の型を変えてよいのは、人手証明の主張と食い違っていることを
  人手証明の正本（`structured-latex/content/`）で示せたときだけで、その理由を状態台帳に書く。
- 通しの証明の各段は、人手証明の対応するブロックと 1 対 1 に対応する具体版である（README「Lean は同じ主張に2つの証明を置く」）。
  新しく立てた主張には、必要十分版の要否を README の基準で判断し、要るなら置く。
- `lean/Ising2D/` のフォルダが、承認された章立て（[six-chapter-organization-proposal.md](six-chapter-organization-proposal.md)）の
  部・章の名前に対応している。旧 Typst の章番号のフォルダ（`Part000`〜`Part020`）は残っていない。
  必要十分版は `Ising2D/NecSuf/` に置く規約（`lean/README.md`）を保つ。本文から退避した経路（整数運動量の経路、
  全スピン反転行列の固有値 −1 の側）の形式化の記録は、内容の分かる名前の別フォルダへまとめる。
- `lake build`、`scripts/check-no-sorry.sh`、`scripts/check-end-to-end.sh` が通る。`lean/README.md` と `lean/docs/` の対応表が
  新しい配置と一致している。

## 作業の順序

上から順に、未完了の最初の項目を進める。進んだ位置は状態台帳 [lean-end-to-end-state.md](lean-end-to-end-state.md) に書く。

2026-10-31 時点で、最終定理 `Ising2D.onsager_exact_solution_unconditional`（`Ising2D/Part018/Theorem013_OnsagerUnconditional.lean`）は
次の仮定を取っている。項目 1〜5 はこれらを一つずつ消す作業である。

1. **双対結合定数を $K_2$ から定める。**（2026-10-31 済み）`IsingParam.K2star := Kstar K2`
   （`Part004/DefinitionSecondDualCouplingConstant.lean`）とし、人手 `duality_c2_star_eq_s2_star_c2` を
   `Part008/ClaimDualityC2StarEqS2StarC2.lean` で形式化して `hdual` を定理 `IsingParam.c2_mul_s2star_eq_c2star` にした。
2. **具体的な分配関数と挟み撃ちをつなぐ。** 最終定理の `Z` はいま「挟み撃ちを満たす任意の関数」である。
   `partitionFunction`（`Part001`）の転送行列表示と、`Part011` の `partition_function_sandwich`・`PhysicalSymTransferBridge.lean` の
   具体的な $V_1^{1/2}, V_2, W$ をつなぎ、`hZ1`・`hZ2` を具体的な $c(M)$（具体的な $W$ の Rayleigh 上限）について証明する。
3. **$W$ と $V^{(+)}$ の橋渡しを構成する。** `EvenSectorBridge`（`Part018/Theorem009_CPlusEqualsLambda.lean`）を、具体的な $W$ と
   `vPlusDataOf` の $V^{(+)}$ について作る（$V^{(+)}$ の実行列表示と、$\mathcal F^{(+)}$ 上で $W x = V^{(+)} x$）。
   `symmetrized_transfer_matrix_on_sectors` は形式化済みなので、実ベクトル上の主張へ変換する。
4. **$\mathrm{tr}(\varepsilon V^{(+)})>0$ を証明する。** 人手証明の `trace_of_epsilon_V_plus`（018 の 1 次元開鎖のスピン和
   `open_chain_partition_sum`・`open_chain_endpoint_product_sum`・`open_chain_spin_sums_positive` と、
   開鎖項・周期境界項 $D_0, G$ の対角作用）を具体版で形式化する。
5. **$W$ の成分の正値性と $\varepsilon$ との可換性を最終定理へ渡す。** `Part011` の `W_has_positive_entries`・
   `ClaimEpsilonCommutesWithW.lean` を、項目 3 の具体的な $W$ について使う。
6. **通しの定理を立てる。** 項目 1〜5 を合わせて `Ising2D.onsager_exact_solution_end_to_end` を証明し、
   `scripts/check-end-to-end.sh` を通す。`check-no-sorry.sh` の `targets` にも足す。ゴール台帳を更新する。
7. **フォルダを章立てに合わせて組み直す。** 構成再編の連続実行（`paper-organization-runbook.md`）が棚卸しへ出力する章の割り当て
   （`docs/organization/flat-inventory.json` の各項目の所属章）に従い、各 Lean ファイルを、それが対応する人手証明のラベルの章の
   フォルダへ移す。フォルダ名は章の名前を英語で表した内容の分かる名前にし、番号を付けない。名前空間は変えない。
   章の割り当てがまだ棚卸しに無ければ、この項目は待ちにして状態台帳に書き、ほかの項目へ進む。
   1 回に 1 章ずつ移し、`Ising2D.lean` の import、`check-no-sorry.sh`、README・`lean/docs/` の対応表、ファイル冒頭の
   `正本:` のパスを同じ回で直す。

## 一回の作業の大きさ

一回の作業は、上の 1 項目とする。項目が大きければ、補題の単位で割り直して状態台帳に書き、先頭の一つだけを行う。
途中の補題を main に入れてよいが、`sorry` を残して入れない。

前回の作業が途中で止まって未コミット成果、または remote default に未包含のローカル成果コミットが残っている場合は継続モードとする。
新しい項目へ着手せず、既存成果の検証・コミット・remote default 反映だけを行う。

## 毎回の手順

- `AGENTS.md`、`CLAUDE.md`、`docs/context/` 全文、プロジェクト README、`lean/README.md`、この Runbook、状態台帳、`MEMORY.md` を読む。
- `origin` を fetch し、remote default branch へ追随する。
- 作業ツリーに `lean/.lake` が無ければ、`lean/` で `lake exe cache get` を実行してからビルドする（mathlib のビルド済みキャッシュ）。
- 状態台帳の「次の一歩」だけを行い、別のエージェントにレビューさせる。レビューは、人手証明との 1 対 1 対応、
  mathlib の一般論への丸投げが無いこと（README 4 節）、主張を弱めていないことを見る。
- `lake build`、`bash scripts/check-no-sorry.sh`、`bash scripts/check-end-to-end.sh`（項目 6 より前は失敗してよい。失敗の理由が
  「定理が無い」であることだけを確かめる）を通す。人手証明の正本や SageMath を変えたら、論文側の `npm run check` と
  `node sagemath/tools/verify-check-linkage.ts` も通す。
- 状態台帳と `MEMORY.md` を更新してコミットし、push 前に `git fetch origin && git rebase origin/main` を行い、
  成果コミットの origin/main への包含を `git merge-base --is-ancestor` で確かめてから終える。

## 並行して同じ論文を触る作業との衝突

構成再編の連続実行「複素行列版イジング: 章立ての組み直し」は、本文のブロックを章ごとに移し、移したブロックを指す
Lean のコメントのパスを直す。lambda 版の連続実行は本文の証明の書式を直す。rebase が衝突したら相手の変更を残し、
こちらの変更をその上にやり直す。
