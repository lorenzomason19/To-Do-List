-- Database: todo_db
-- Descrizione: Database per l'applicazione To-Do List con autenticazione utenti

-- Crea il database se non esiste
CREATE DATABASE IF NOT EXISTS todo_db;
USE todo_db;

-- Tabella utenti
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabella attività (todos)
CREATE TABLE IF NOT EXISTS todos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    completed BOOLEAN DEFAULT FALSE,
    priority ENUM('LOW', 'MEDIUM', 'HIGH') DEFAULT 'MEDIUM',
    due_date DATE,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Indici per migliorare le performance
CREATE INDEX idx_todos_user_id ON todos(user_id);
CREATE INDEX idx_todos_completed ON todos(completed);
CREATE INDEX idx_todos_due_date ON todos(due_date);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);

-- Inserimento dati di esempio (opzionale)
INSERT INTO users (username, email, password) VALUES 
('admin', 'admin@todo.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa'), -- password: admin123
('user1', 'user1@todo.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa'); -- password: admin123

INSERT INTO todos (title, description, completed, priority, due_date, user_id) VALUES 
('Completare progetto Spring Boot', 'Implementare tutte le API REST per il backend', FALSE, 'HIGH', '2024-01-15', 1),
('Creare frontend Angular', 'Sviluppare l\'interfaccia utente per la gestione delle attività', FALSE, 'HIGH', '2024-01-20', 1),
('Testare l\'applicazione', 'Eseguire test di integrazione tra frontend e backend', FALSE, 'MEDIUM', '2024-01-25', 1),
('Comprare il pane', 'Acquistare pane fresco per la colazione', TRUE, 'LOW', '2024-01-10', 2); 