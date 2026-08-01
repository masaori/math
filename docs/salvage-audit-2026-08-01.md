# main 未統合成果のトリアージ（2026-08-01）

[前回の棚卸し](salvage-audit-2026-07-31.md)（調査時点 `origin/main = af8d209`）以降に進んだ分を含め、
**全 worktree・全 local/remote branch・全 open/closed PR** を再度トリアージした記録。

- **調査時点の `origin/main`**: `b9d55f7`（integrable-lattice auto-loop cycle22 step1・step2 のマージ）
- **remote default branch**: `git remote show origin` の `HEAD branch` で `main` と確認（決め打ちしていない）
- **判定方法**: コミット ID の非包含だけでは判定していない。各候補について
  1. `git merge-tree --write-tree origin/main <branch>` の結果 tree が `origin/main` の tree と一致するか（＝マージしても何も変わらないか）
  2. 一致しない場合は、差分の**中身**を main 側の同一パス／改名先／後続実装と読み比べる
  3. PR の状態（open / closed / merged）と、その PR に残っている判定コメント
  を突き合わせた。
- **worktree・branch・tmux window は一切削除していない。** locked worktree の内容も変更していない。

## 1. 調査範囲

| 対象 | 件数 | 内訳 |
|---|---|---|
| worktree | 18 | 全て `git status --porcelain` が 0 件（未コミット変更・未追跡ファイルともゼロ） |
| local branch | 226 | `origin/main` より先に進んでいたのは 34 本 |
| remote branch | 116 | `origin/main` より先に進んでいたのは 34 本（`origin/gh-pages` は共通祖先を持たない CI 出力なので対象外） |
| PR | 74 | open 7・closed 22・merged 45 |

local 側の 34 本は remote 側の 34 本とほぼ同一集合で、remote に無い固有作業は
`copilot-worktree-2026-02-17T02-42-05`（前回「価値なし」判定済み）のみだった。

## 2. 候補ごとの判定

### 2-1. 現在 active（触っていない）

| ブランチ | 根拠 |
|---|---|
| `goal-il-cycle22` / `worktree-greedy-marinating-papert` / `worktree-unified-greeting-creek` | いずれも 2026-08-01 の integrable-lattice auto-loop cycle 22 の step 成果。worktree が locked で、別セッション（tmux `math:2.0`）が現在 cycle 22 を進行中。呼び出し元がそのセッションで検証・マージする作業単位なので、こちらからは触らない |
| `goal-il-cycle19` | worktree が locked。cycle 21 の担当セッション（tmux `math:3.0`）が保持中 |

### 2-2. 既に別コミットで統合済み（マージしても tree が変わらない＝no-op）

`git merge-tree --write-tree origin/main <branch>` の結果 tree が `origin/main` の tree と**バイト一致**した。

- `worktree-cheerful-humming-rossum`（cycle17 construct_nontrivial_delta_examples）
- `worktree-ancient-herding-forest`（cycle16 verify_monsky_cuoco_monsky_primary）
- `worktree-moonlit-greeting-zebra`（cycle17 prior_art_check_for_submission）
- `goal-dead-work-audit` / PR #65（前回の棚卸し記録そのもの。main の `196c4e5` として既に入っている）

### 2-3. 上位実装で代替済み

| 候補 | main 側の状態（一次情報） |
|---|---|
| `worktree-woolly-inventing-cray`（cycle17 T3 torus odd ell、1813 行） | 同じパスが main に存在。sage スクリプト・RESULTS.md は**バイト一致**、レポート `cycle17_T3_degenerate_torus_odd_ell.md` は **main 側が 12 行多い上位版** |
| `worktree-distributed-sprouting-pike` / PR #66（Lean `Abstract/Conjugation.lean`） | main は `Abstract/` を **`NecSuf/` へ改名**済み。`NecSuf/Conjugation.lean` が `sandwich` / `conjRingHom` / `conjRingAut` 等を全て持ち、さらに `sandwich_mul_needs_left_inv` / `sandwich_one_needs_right_inv`（仮定が必要であることを示す否定コントロール）を追加している。具体版も `Part000/Claim045_ConjugationIsRingHomFromNecSuf.lean` として存在 |
| `worktree-mossy-foraging-gem` / PR #68（Lean `Abstract/GeneratedByBasis.lean`） | 同様に `NecSuf/GeneratedByBasis.lean` が `eq_top_of_basis_mem` / `string_mem` 等を持ち、`local_mem` / `map_mem_subalgebra_of_mulSingle_mem` まで拡張済み。具体版は `Part004/Claim014_ZYGenerateAlgebraFromNecSuf.lean` |
| `worktree-piped-brewing-kahan` / PR #69（Lean `PropCPeriod.lean` + `refs.bib`） | ブランチ側 `PropCPeriod.lean` は **`sorry` を 1 件含む**。main の同名ファイルは `sorry` 0 件で、`orderOf_reduction_dvd` / `matrix_pow_mul_prime_pow_eq_one` 等を持つ別系統の完成版。`refs.bib` はブランチ 14 エントリに対し **main は 24 エントリ**。ブランチのみにある `AxKochen1965I/II/1966III` は、main が `AxKochen1966` へ統合し「第 III 部の題名が "Decidable Fields" であることを Crossref で確認」と `paper001_en_citation_review.md` に記録済み |
| PR #21〜#25 の各ブランチ（`worktree-eventual-cuddling-deer` / `foamy-foraging-map` / `fuzzy-petting-bengio` / `indexed-singing-blum` / `nifty-drifting-engelbart`） | 有効残余は **PR #64（merged）** が main へ統合済み。main 側で実在を確認: `130_matrix_norm_triangle_inequality/check_02_limit_uniqueness.sage`、`132_matrix_norm_vector_bound/check_02_proof_path_W.sage`、`133_matrix_completeness/check_02_cauchy_completeness.sage`、`255_def_T_g/`、`260_def_T_V/`、`cycle13_T3_criterion_proof/verify_star.sage` と `verify_criterion.sage`、`MEMORY.md` の `(2s+4)L-(6s+1)` と OEIS A212800 の記録 |
| PR #61 / #62 / #63 | いずれも merged。前回の棚卸しで起こした救済 PR |

### 2-4. 不要

| 候補 | 根拠 |
|---|---|
| `worktree-buzzing-foraging-widget` / PR #74 | 差分は `package-lock.json` 2 本の追記のみ。パッケージマネージャの生成物で、このリポジトリは `pnpm-lock.yaml` を正本にしている |
| `feat/lean-fermion-psi-TV` / PR #55（closed） | 同じく `package-lock.json` の追記のみ |
| `goal-source-inconsistency` / PR #58（closed） | `045_claim_free_energy/probe_tmp.sage` とその生成物のみ。名前どおりの一時プローブで、`overview.md` も無い |
| `worktree-lovely-dreaming-boot` / PR #67 | `cycle16_T3_lower_order/degenerate_odd.out` の差し替え 1 ファイル。内容は同じ検査の再実行ログで、`ell=29 M=2` が main 側「PARI stack overflow で ERROR」→ ブランチ側「1200 秒で打ち切り → **未検証**」に変わるだけ（どちらも未検証なので数学的な新規情報はゼロ）。加えて**ブランチ側のファイルは末尾が上書き途中で壊れている**（`[ 4185.3s] 終了` の後に前回実行の `3070.9s] 終了` が残留）。取り込むと main の正常なログが壊れたログに置き換わる |
| `worktree-mossy-foraging-gem` の `logs/cache-get.log` 削除、`worktree-piped-brewing-kahan` の同ファイル削除 | ビルドキャッシュ取得ログの削除で成果ではない |
| `origin/gh-pages` | main と共通祖先を持たない CI デプロイ出力（`.nojekyll` / `index.html` / `main.pdf`） |
| 前回「価値なし」と判定した 10 件（PR #18 / #26 / #27 / #28 / #29 / #38 / #39 / #47 / #48 / #49）、`origin/claude/zen-allen-gojq1o`、`copilot-worktree-2026-02-17T02-42-05`、`origin/copilot/fix-arg-interval` | [前回の記録](salvage-audit-2026-07-31.md) の判定を再確認した。判定を覆す材料は出ていない |

### 2-5. 有効で未統合（今回 main へ統合した）

**`salvage/uncovered-sage-checks` / PR #70 のうち、`201_def_hatZ_hatY/check_01_two_forms_of_definition.sage` だけ。**

同ブランチの他のファイルは以下のとおり不要と判定した。

- `146_def_matrix_norm/` … main の **`129_def_matrix_norm/`** が同じ 2 本の check を同じ対象ラベルで持つ（採番違いの重複）。しかも main 側の方が本文の表現が整っている
- `255_def_T_g/` `260_def_T_V/` … main に同名ファイルが存在。差分はブランチ側ヘッダのコメントが**古い採番（253 / 254）**を指している 2 行だけで、main 側が正しい
- `201_def_hatZ_hatY/check_02_plus_minus_differ_only_at_j1.sage` … main の `191_hatZ_hatY_M_periodicity/check_01_periodicity.sage` が最終ブロックで
  `hatZ^(-) - hatZ^(+) = 2 Z_1 e^{-i2πμ/M}` を検査済み。さらにブランチ側のこの check の**実行ログは 0 バイト**（未完走）

残った `check_01` を有効と判断した根拠:

- **対象ラベル `def_hatZ_hatY` を宣言する check が main に 1 件も無い**
  （`git grep -l "対象ラベル.*def_hatZ_hatY" origin/main -- exact-solution-of-2d-ising-model/sagemath/check` が 0 件）。
  一方このラベルは `structured-latex/labels.generated.ts` に実在し、本文
  `content/004_transfer_matrix.ts` のブロック `transfer_matrix_010_definition_hatZ_hatY` が定義している。
- 本文はこの定義で hatZ^{(±)}_μ を **2 通りの式で書き、等号で結んでいる**（cases 記法と、j=1 の項を
  和の外へ出した形）。この等号は本文が主張している事柄で、定義が一意に定まること（well-defined 性）に
  直結する。リポジトリ CLAUDE.md の「定義が意味をもつ条件・well-defined 性は本文の一部」という方針に照らして、
  検証が無い状態は穴である。
- main の `191_hatZ_hatY_M_periodicity` は**周期性**と**(+)/(−) の差**を見ており、この等号は見ていない。

**統合時に加えた変更**

- ヘッダのコメントに「経路 C」として、実装されていない検証（基底ベクトルの像から行列を組む経路）が
  書かれていたので、実際のコードに合わせて書き直した（後半ブロックは、j=1 の重み ∓1 を行列成分 (0,0)
  から読み取る経路である）。
- ブランチに無かった **`overview.md` を新規に書いた**（これが無いと
  `node sagemath/tools/verify-check-linkage.ts` が exit 1 で落ちる）。数値は自分で実行したログから取った。
- **自分で SageMath を実行して再現した**（ブランチのログを転記していない）。
  `checks: 116, max relative error: 3.708e-17, tol: 1.0e-09, RESULT: PASS`。

## 3. 通した検証

`exact-solution-of-2d-ising-model` 配下で以下を実行し、すべて exit 0 を確認した。

```
sage check_01_two_forms_of_definition.sage        → checks: 116, max rel err 3.708e-17, PASS
bash sagemath/tools/run-all-checks.sh 201         → ran 1 check script(s), 0 failed
node sagemath/tools/verify-check-linkage.ts       → verified 116 check(s) linked to structured-latex labels (252 labels available)
node structured-latex/tools/validate-content.ts   → 300 blocks / 252 labels / 1853 refs, all resolved; notes 38 / 48 targets, all resolved
node structured-latex/tools/verify-no-lost-proofs.ts → no lost proofs
(cd structured-latex && npm run check)            → 型検査・実行時検証・移行漏れ検出・負テスト 16 ケース・実行時検証テスト 51 件すべて pass
```

**`lake build` は実行していない。** 今回の差分に Lean ファイルが 1 つも含まれていない
（`git diff --name-only origin/main...HEAD | grep -i lean` が 0 件）ためで、かつ
`integrable-lattice/docs/tasks/auto-loop-state.md` に「Lean を含む step は他の重い作業と
同時に走らせない」という申し送りがあり、現在別セッションが cycle 22 の Lean 作業を進行中である。

## 4. この調査で行った操作

- 新規追加: `exact-solution-of-2d-ising-model/sagemath/check/201_def_hatZ_hatY/`（check 1 本・`overview.md`・実行ログ・生成 `.sage.py`）
- ルート `CLAUDE.md` / `AGENTS.md` に「完了とは remote default branch に成果コミットが含まれること」を明文化
- **worktree・branch・tmux window の削除は一切していない。** locked worktree の内容も変更していない
- open のまま残した PR #66 / #67 / #68 / #69 / #70 / #74 は、上記の判定どおり main へ入れる内容が
  （#70 の 1 ファイルを除いて）残っていない。**クローズはしていない**（判定の記録をここに残すに留めた）
