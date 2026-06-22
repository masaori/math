# 可積分だが厳密解が未確定な格子模型カタログ（first pass）

問い: 「YBE で可積分とわかっているが厳密解はまだ求まっていない模型のリストはあるか」。

## 結論（一次情報ベース）

- **単一の公式リストは無い**。が、(1) 体系的な生成源と (2) 開問題を正面から扱う権威ある叙述がある。
  - **生成源**: YBE 解（＝可積分2D 格子模型）は**アフィン Lie 代数 / 量子群（Drinfeld–Jimbo）で分類**される（cond-mat/0304309）。各 アフィン代数 × 表現 × (vertex/IRF/RSOS) が可積分模型を1つ与える。「可積分」は構成上保証されるが、「閉形式で厳密に解けている」のははるかに少数。**この差が探すべきリスト**。
  - **開問題の叙述**: McCoy「Integrable models in statistical mechanics: the hidden field with **unsolved problems**」(math-ph/9904003, 1999 Heineman 賞講演) と Baxter「The challenge of the chiral Potts model」(cond-mat/0510683)。

## Λ プログラムとの関係（なぜこれが探すべき母集団か）

可積分 ⇒ Bethe/スペクトル方程式が**代数的** ⇒ **有限 N のスペクトル・零点は ℚ̄（決定可能, 方向 C-U3）**。一方「厳密解が未確定」＝**極限の閉形式が無い（07-4 可解性が ×）＝ℝ脱出先が未定**。
よってこれらの模型では「**有限 N は Λ/ℚ̄ で決定可能だが、極限は未解決**」という Λ-statement が**非自明な内容を持つ**（既解の Ising では自明だった、cycle1 step1 の判定）。**ここが本プロジェクトの本命母集団**。

## カタログ（原典付き first pass。各エントリ: 模型 / 未解決部分 / 出典 / Λ ハンドル）

```yaml
- model: カイラル Potts 模型 (N≥3)
  integrable_by: YBE / star-triangle（高種数 θ 関数, genus>1）
  unsolved:
    - 秩序変数: M_n=(1−k^2)^{n(N−n)/2N^2} は McCoy が予想(1989), Ising(N=2)は Yang 1952, N≥3 は長年未証明（後に Baxter 2005 が証明）。
    - 完全な固有値スペクトル: 自由エネルギー(Baxter 1988)は解けたが、スペクトル全体への拡張に問題が残る。
    - 相関関数: 高種数代数幾何のため極めて困難。
  source: [math-ph/9904003(McCoy), cond-mat/0510683(Baxter challenge)]
  lambda_handle: 有限 N 転送行列スペクトルは代数的(ℚ̄)。極限の自由エネルギー/秩序変数が ℝ 側で困難。
- model: 2次元 Ising 帯磁率（感受率）χ
  integrable_by: 自由フェルミ（模型自体は可解）
  unsolved:
    - χ の級数の解析構造: Nickel 予想で |v|=1 上に特異点が稠密化＝自然境界。可積分/非可積分を分ける性質の可能性。閉形式での特徴付けは未確定。
  source: [math-ph/9904003(McCoy, Nickel 予想)]
  lambda_handle: 各次の級数係数は有理/代数的。自然境界は ℝ/ℂ 側。
- model: 一般の可積分massive模型の相関関数
  integrable_by: YBE / Bethe ansatz
  unsolved:
    - 相関関数を「古典可積分方程式(非線形 微分/積分/差分)の解」として特徴付ける（McCoy 中心予想）。CFT の線形方程式を massive の非線形へ拡張するのは「広大な未開拓領域」。
  source: [math-ph/9904003(McCoy)]
  lambda_handle: 有限 N 相関は代数的(ℚ̄)。閉形式の極限が未解決。
- model: フェルミオン表現（Rogers–Ramanujan）の完全性
  integrable_by: RSOS / CTM
  unsolved:
    - 各 CFT に複数の異なるフェルミオン表現が存在するが、完全な集合は未知（探索継続中）。
  source: [math-ph/9904003(McCoy)]
  lambda_handle: 有限化指標は ℤ[q]（可算）。完全性の主張が未確定。
- model: 高ランク/高スピン vertex・IRF 模型（A_n^{(1)}, B/C/D, 例外型, 融合階層）
  integrable_by: 量子群/アフィン Lie 代数（構成上 YBE）
  unsolved:
    - nested Bethe ansatz でスペクトルは原理的に書けるが、閉形式の熱力学・相関・Bethe ansatz の完全性は多くで未解決。
  source: [cond-mat/0304309(分類レビュー)]
  lambda_handle: Bethe 方程式=代数的⇒有限 N∈ℚ̄。極限が未解決＝本命。
- model: dilute A_2^{(2)} ループ模型 / 融合 T-system・Y-system
  integrable_by: YBE / Temperley-Lieb 融合
  unsolved:
    - T/Y-system は閉じるが、閉形式の自由エネルギー・相関は部分的。
  source: [arXiv:1905.07973]
  lambda_handle: T/Y-system は有限の代数的関係（ℚ̄(x)）。極限が未確定。
- model: Bethe ansatz の完全性（多数の模型）
  integrable_by: algebraic Bethe ansatz
  unsolved:
    - Bethe 根が固有状態を尽くすか（完全性）は多くの模型で未解決の一般問題。
  source: [一般（McCoy, レビュー）]
  lambda_handle: Bethe 方程式=代数的方程式系（有限 N で ℚ̄）。完全性は数え上げ＝可算命題化の余地。
```

## 観察・含意

- 本命は **カイラル Potts**（秩序変数 N≥3 は 2005 に決着済みだが、相関・スペクトル全体はなお困難）と **高ランク/高スピン vertex・IRF 模型**（極限閉形式・相関・Bethe 完全性が広く未解決）。これらは「有限 N＝ℚ̄ 決定可能だが極限未解決」が非自明に成り立つ。
- cycle1 step1 の判定（Ising 零点は既知で自明）を踏まえると、**Λ-statement の本命はこの未解決母集団に当てる**べき。すなわち C-U3（Bethe 有限 N∈ℚ̄）・D（Massieu Φ∈Λ）・F（形式検証）を、Ising でなく**この未解決模型**に適用する。
- 次手: このカタログを harvest 起点に、(a) 各模型の「有限 N で何が ℚ̄/Λ で決定可能か」を C-U3 の枠で具体化、(b) E テーブル（complexity×solvability）へ配置。
