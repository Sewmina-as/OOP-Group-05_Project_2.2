package com.social.app.dto;

import com.social.app.model.Notification;

import java.time.LocalDateTime;

/**
 * Flat DTO sent to the frontend — never serialize the JPA entity directly.
 */
public class NotificationDTO {

    public Long id;
    public String type;
    public String actorName;
    public char actorInitial;
    public String message;
    public String link;
    public boolean read;
    public LocalDateTime createdAt;

    public static NotificationDTO from(Notification n) {
        NotificationDTO dto = new NotificationDTO();
        dto.id = n.getId();
        dto.type = n.getType().name();
        dto.actorName = n.getActor().getFullName();
        dto.actorInitial = n.getActor().getFirstName().charAt(0);
        dto.message = n.resolveMessage();
        dto.link = n.resolveLink();
        dto.read = n.isRead();
        dto.createdAt = n.getCreatedAt();
        return dto;
    }
}
