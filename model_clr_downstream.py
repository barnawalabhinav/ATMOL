import torch.nn as nn
import torch.nn.functional as F

class Model(nn.Module):
    def __init__(self, n_output=1, output_dim=128, dropout=0.2, encoder=None):
        super(Model, self).__init__()
        self.output_dim = output_dim
        self.n_output = n_output
        self.encoder = encoder
        self.dropout = dropout

        # predict
        self.pre = nn.Sequential(
            nn.Linear(output_dim, 64),
            nn.Dropout(dropout),
            nn.Linear(64, self.n_output)
        )

    def forward(self, data):
        x, edge_index, batch, y = data.x, data.edge_index, data.batch, data.y

        # encoder drug1
        x1, w = self.encoder(x, edge_index, batch)

        xf = F.normalize(x1)

        xc = self.pre(xf)
        out = xc.reshape(-1)

        len_w = edge_index.shape[1]
        weight = w[1]
        edge_weight = weight[:len_w]
        x_weight = weight[len_w:]

        return out, y, edge_weight, x_weight
