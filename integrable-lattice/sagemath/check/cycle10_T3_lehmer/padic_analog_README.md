# cycle 11 / T3: Lehmer 問題の p 進版はない — 双対の決定可能性非対称の集約

文献: Ferrero–Washington 定理(1979, 岩澤 μ=0 for cyclotomic $\mathbb{Z}_p$-ext of abelian fields); p-adic Mahler measure & ℤ-covers of links (arXiv:1702.03819, Alexander 多項式先頭係数・p 進エントロピー・岩澤 μ_p の balance formula); Iwasawa theory(Sharifi ノート)。

## 問い

ℝ/Λ 双対の ℝ 側は Lehmer 問題（Mahler 測度＝自由エネルギー＝エントロピーの最小正値ギャップ, 未解決）に触れる（cycle10 T3）。**Λ 側（p 進）に Lehmer の類似はあるか?**

## 結論: Λ 側に Lehmer 型問題は存在しない（決定可能側）

- **ℝ 側**: Mahler 測度 $m(P)\in\mathbb{R}$ は**連続**。Lehmer 問題＝「$m(P)>1$ の最小値は? $1$ に近づけるか?」＝**連続的ギャップ問題, 未解決**。
- **Λ 側**: p 進エントロピー＝岩澤 $\mu_p$ 不変量は **整数値** $\mu_p\in\mathbb{Z}_{\ge0}$（**離散**）。よって「上から $0$/$1$ へ近づく」という Lehmer 型の問いは**そもそも立たない**（最小正値は自明に $1$, ギャップ $1$ が自動的）。
- さらに **Ferrero–Washington**: cyclotomic $\mathbb{Z}_p$-拡大（abelian 体）では $\mu_p=0$（generic に消える）。非自明 $\mu_p$ は特別。graph 版（cycle11 T1 の全域木岩澤理論）でも同様の μ=0 現象。

## 双対の非対称性の集約（ユーザーの研究ノート §3.1 と一致）

| | ℝ 側（アルキメデス） | Λ 側（p 進） |
|---|---|---|
| 対象 | Mahler 測度 = エントロピー ∈ ℝ（連続, 非可算） | 岩澤 μ_p = p 進エントロピー ∈ ℤ（離散, 可算） |
| 最小正値問題 | **Lehmer 問題（未解決, 連続ギャップ）** | 自明（整数値, 最小正値=1） |
| 一般の値 | 計算不能実数もありうる | Ferrero–Washington で generic に 0, 決定可能 |

⇒ **「難しい/未解決な連続問題（Lehmer）は双対の ℝ 側だけに現れ、Λ 側は離散・決定可能・（generic に）解決済み」**。これは本プロジェクトの決定可能性非対称（研究ノート §3.1: Λ 側は $\mathbb{Q}_p$ 不要で可算・決定可能, ℝ 側の非可算性は除去不能）の、**Lehmer/岩澤という具体的な famous problem での集約**。

## T3 としての位置づけ（正直に）

- **確定（概念的・文献ベース）**: Lehmer 問題は双対の ℝ 側固有。Λ 側（μ_p∈ℤ, Ferrero–Washington）に対応する未解決連続ギャップは無い。決定可能性非対称の鮮明な例。
- 新しい定理ではなく、**既知の2つの理論（Lehmer/Mahler と 岩澤/Ferrero–Washington）が双対の両素点にどう分かれて乗るかの地図**。誇張しない。
- これで cycle10 T3（Lehmer 接続）＋ cycle6/11 T1（p 進エントロピー＝岩澤 μ）が、双対の非対称性として一貫した像に収束。
