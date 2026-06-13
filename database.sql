-- Tabela de usuários
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) DEFAULT 'client',
    wallet_address VARCHAR(42),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de telhados
CREATE TABLE roofs (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    area DECIMAL(10,2) NOT NULL,
    address TEXT,
    has_solar BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de transações CSGS
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    amount DECIMAL(20,8) NOT NULL,
    type VARCHAR(20) CHECK (type IN ('mint', 'transfer', 'burn', 'reward')),
    tx_hash VARCHAR(66),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de fornecedores
CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    contact_name VARCHAR(100),
    contact_phone VARCHAR(20),
    contact_email VARCHAR(100),
    service_area TEXT,
    approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Inserir admin padrão (senha: admin123 – será hash depois)
INSERT INTO users (name, cpf, email, password_hash, role) 
VALUES ('Admin', '00000000000', 'admin@synapseglobalis.com', '$2b$10$N9qo8uLOickgx2ZMRZoMy.MrkJ5x5lE6Q8Z6XvQe1J6X7xH9X8X', 'admin');
