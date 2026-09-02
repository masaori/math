# sagemath/check — 種の検算

各検算は `<対象名>/` に置き、`overview.md` に**対象ラベル**（どの種・どの命題を検証するか）を宣言する。
規約はリポジトリ共通（[CLAUDE.md](../../../CLAUDE.md) のプロジェクトテンプレート）。

## 実施済みの検算

| ディレクトリ | 対象 | 結果 |
|---|---|---|
| [`clifford_matrix_tower/`](clifford_matrix_tower/) | $\mathrm{Cl}_{2n}(\mathbb{C})\cong M_{2^n}(\mathbb{C})$（Jordan–Wigner 生成元、$n=1,2,3$） | **合致**。$\mathbb{R}$ 脱出なし |
| [`essential-dependency-support/`](essential-dependency-support/) | 本質的依存と一点反転検査の同値、および依存台の有限走査 | 実行結果は各 `overview.md` を正本とする |
| [`redundant-neighbor-independence/`](redundant-neighbor-independence/) | 冗長拡大による追加元への非依存、依存の移送、本質的依存台の不変性 | 実行結果は各 `overview.md` を正本とする |
| [`time-expansion-dependency/`](time-expansion-dependency/) | 大域写像の一点反転、イベント集合、一段依存関係、時刻増加 | 実行結果は各 `overview.md` を正本とする |
| [`finite-propagation-boundary/`](finite-propagation-boundary/) | 経路の時刻差、伝播球、依存元集合の有限伝播境界 | 実行結果は各 `overview.md` を正本とする |
| [`local-rule-representation/`](local-rule-representation/) | 局所規則で表せること $\iff$ 本質的依存台の包含、依存台の最小性、単射な大域写像の逆写像の最小近傍 | 実行結果は各 `overview.md` を正本とする |
| [`iterate-monoid/`](iterate-monoid/) | 反復回数の加法と写像合成の一致、反復写像の衝突と有限代表集合、反復写像がなす有限可換モノイド、その真理値表からの有限決定 | 実行結果は各 `overview.md` を正本とする |
| [`inverse-map-locality-exploration/`](inverse-map-locality-exploration/) | 探索（未昇格）: 単射な大域写像の逆写像の本質的依存台と順写像の依存台の比較 | **反例あり**（$L=5$ 規則 45 で逆写像の依存台が舞台全体）。詳細は `overview.md` |

## 予定されている検算（未着手）

| ディレクトリ | 対象 | 出典 |
|---|---|---|
| `rule_invariants/` | **第一相の総当たり**: 初等 CA 256 個 × 保存量・$Z_N$・ゼータ関数・次元群・Bowen–Franks 群・線形性・可逆性。識別力も測る | [CAから出発する代数構造の探索](../../docs/survey/CAから出発する代数構造の探索.md) 「次にやること」節 |
| `lambda_thermodynamics/` | 種「Λ値熱力学の構成」: 加法的保存量 → $\Omega\in\mathbb{N}$ → $S,\beta\in\Lambda$ → 第〇法則 | [ideas 一覧](../../docs/ideas/アイディアの種_一覧.md) 種「Λ値熱力学の構成」 |
| `phi_support/` | 種「Φ_N の台と代数的複雑度」: $\Phi_N$ の台。初等 CA 256 個 × $L$ × $N$ | [ideas/01](../../docs/ideas/種_Φ_Nの台と代数的複雑度.md) 「最初の検算（`sagemath/check/phi_support/` に置く）」節 |
| `ledrappier_padic/` | 種「線形CAとMahler測度」: Ledrappier three-dot の三素点突き合わせ | [ideas/02](../../docs/ideas/種_線形CAとMahler測度.md) 「最初の検算（`sagemath/check/ledrappier_padic/`）」節 |
| `lambda_invariants/` | 種「Λ値不変量の三つの顔」: $\log\operatorname{ind}$ / $h$ / $M$ の比較表 | [ideas/03](../../docs/ideas/種_Λ値不変量の三つの顔.md) 「最初の検算」節 |
| `finite_predicates/` | 種「可解性は有限検査で決まる」: 線形性・可逆性・保存量の総当たり | [ideas/00](../../docs/ideas/アイディアの種_一覧.md) 種「可解性は有限検査で決まる」 |

## 検算の原則

- **厳密計算のみ**。$\mathbb{Z}$/$\mathbb{Q}$/$\overline{\mathbb{Q}}$（`ZZ`/`QQ`/`QQbar`）と素因数分解で行い、
  浮動小数点は使わない。$\mathbb{R}$ を使う箇所（Mahler 測度の数値評価など）は
  **その旨を `overview.md` に種類つきで明記する。**
- 結果は `overview.md` に、実行ステータス・入力・出力・結論の順で記録する。
- 仮説が**否定された場合も必ず記録する**（種の「潰れ方」の欄を更新する）。
- **木の形は一段だけ**。`sagemath/check/` の直下に置けるのはこの README と検算ディレクトリだけで、
  検算ディレクトリの中に置けるのは通常ファイルだけである（入れ子の検算とディレクトリへの symlink を
  作らない）。これは [`../tools/verify-check-linkage.ts`](../tools/verify-check-linkage.ts) が
  検査しており、外れたものは「検査されないまま読み飛ばされる」として失敗する。

## 全数掃引の回し方

`sagemath/check/` 配下の `.sage` を 1 本ずつ別の `sage` プロセスで起動すると、起動そのものが
1 本あたり約 24 秒かかり、掃引全体が検算の計算量ではなく起動時間で律速される。そのため全数掃引は
[`../tools/sweep_all_checks.py`](../tools/sweep_all_checks.py) を使う。ワーカー 1 プロセスの中で
各検算を隔離した名前空間へ `load` し、次に実行する 1 本を共有カウンタから取り出す。

```sh
sage -python sagemath/tools/sweep_all_checks.py driver --jobs 12 --timeout 600 --outdir /tmp/ca-sage-sweep
```

結果は `--outdir` の `result-<ワーカー番号>.jsonl` に 1 本 1 行で残る（`file` / `status` / `seconds`）。
`status` は `PASS` / `FAIL` / `TIMEOUT` のいずれかで、`--timeout` を超えた検算は握り潰さず
`TIMEOUT` として記録する。driver は全ファイルが重複なく一度ずつ `PASS` したことまで集計し、
`FAIL` / `TIMEOUT`、ワーカーの異常終了、結果の欠落・重複・破損が一つでもあれば終了コード 1 を返す。

この経路が満たしている条件は二つある。**隔離名前空間**: 検算ファイル内の相対 `load` も同じ
名前空間へ入れる（名前空間を指定しないと Sage の利用者名前空間へ入り、`_common.sage` で定義した
関数が検算から見えない）。**動的キュー**: 分割を静的に決めると計算量の重い検算が特定のワーカーへ
偏り、他のワーカーが空いたまま掃引が終わらない。
